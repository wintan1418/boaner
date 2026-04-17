require "net/http"
require "json"
require "uri"

class YoutubeSyncService
  API_BASE = "https://www.googleapis.com/youtube/v3"

  # Sync a single channel
  def initialize(youtube_channel)
    @channel = youtube_channel
    @api_key = youtube_channel.api_key
    @channel_id = youtube_channel.channel_id
  end

  # Sync all channels that have auto_sync enabled
  def self.sync_all!
    results = []
    YoutubeChannel.auto_syncable.find_each do |channel|
      result = new(channel).sync!
      result[:channel] = channel.name
      results << result
    end
    results
  end

  def sync!
    return { error: "API key not configured" } if @api_key.blank?
    return { error: "Channel ID not configured" } if @channel_id.blank?

    videos = fetch_channel_videos
    return { error: "Failed to fetch videos from YouTube" } if videos.nil?

    created = 0
    updated = 0

    videos.each do |yt_video|
      video = Video.find_or_initialize_by(youtube_id: yt_video[:youtube_id])
      is_new = video.new_record?

      video.assign_attributes(
        title: yt_video[:title],
        description: yt_video[:description],
        published_at: yt_video[:published_at],
        category: yt_video[:category] || "Video",
        youtube_channel: @channel
      )

      if video.save
        is_new ? created += 1 : updated += 1
      end
    end

    @channel.update(last_synced_at: Time.current)
    { created: created, updated: updated, total: videos.size }
  end

  private

  def fetch_channel_videos
    channel_url = "#{API_BASE}/channels?part=contentDetails,snippet&id=#{@channel_id}&key=#{@api_key}"
    channel_data = api_request(channel_url)
    return nil unless channel_data

    items = channel_data.dig("items")
    return nil if items.blank?

    uploads_playlist_id = items[0].dig("contentDetails", "relatedPlaylists", "uploads")
    return nil if uploads_playlist_id.blank?

    videos = []
    next_page = nil

    2.times do
      playlist_url = "#{API_BASE}/playlistItems?part=snippet&playlistId=#{uploads_playlist_id}&maxResults=50&key=#{@api_key}"
      playlist_url += "&pageToken=#{next_page}" if next_page

      playlist_data = api_request(playlist_url)
      break unless playlist_data

      (playlist_data["items"] || []).each do |item|
        snippet = item["snippet"]
        next if snippet["resourceId"]["kind"] != "youtube#video"

        videos << {
          youtube_id: snippet["resourceId"]["videoId"],
          title: snippet["title"],
          description: (snippet["description"] || "").truncate(500),
          published_at: Time.parse(snippet["publishedAt"]),
          category: categorize_video(snippet["title"], snippet["description"])
        }
      end

      next_page = playlist_data["nextPageToken"]
      break if next_page.blank?
    end

    videos
  end

  def categorize_video(title, description)
    text = "#{title} #{description}".downcase
    if text.match?(/history|histor|ancient|colonial|empire|kingdom|war|battle/)
      "History"
    elsif text.match?(/story|stories|tale|narrative|fiction/)
      "Story"
    elsif text.match?(/lecture|lesson|teach|class|course|education/)
      "Lecture"
    elsif text.match?(/review|book|read/)
      "Spiritual"
    else
      "Music"
    end
  end

  def api_request(url)
    uri = URI(url)
    response = Net::HTTP.get_response(uri)

    if response.is_a?(Net::HTTPSuccess)
      JSON.parse(response.body)
    else
      Rails.logger.error "YouTube API error: #{response.code} - #{response.body}"
      nil
    end
  rescue StandardError => e
    Rails.logger.error "YouTube API request failed: #{e.message}"
    nil
  end
end
