class YoutubeSyncService
  API_BASE = "https://www.googleapis.com/youtube/v3"

  def initialize
    @settings = SiteSetting.instance
    @api_key = @settings.youtube_api_key
    @channel_id = @settings.youtube_channel_id
  end

  def sync!
    return { error: "YouTube API key not configured" } if @api_key.blank?
    return { error: "YouTube channel ID not configured" } if @channel_id.blank?

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
        category: yt_video[:category] || "Video"
      )

      if video.save
        is_new ? created += 1 : updated += 1
      end
    end

    { created: created, updated: updated, total: videos.size }
  end

  private

  def fetch_channel_videos
    # Step 1: Get uploads playlist ID
    channel_url = "#{API_BASE}/channels?part=contentDetails,snippet&id=#{@channel_id}&key=#{@api_key}"
    channel_data = api_request(channel_url)
    return nil unless channel_data

    items = channel_data.dig("items")
    return nil if items.blank?

    uploads_playlist_id = items[0].dig("contentDetails", "relatedPlaylists", "uploads")
    return nil if uploads_playlist_id.blank?

    # Step 2: Fetch videos from uploads playlist (up to 50)
    videos = []
    next_page = nil

    2.times do # Max 2 pages = 100 videos
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
      "Review"
    else
      "Video"
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
