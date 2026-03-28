class YoutubeSyncJob < ApplicationJob
  queue_as :default

  def perform(channel_id = nil)
    if channel_id
      channel = YoutubeChannel.find(channel_id)
      result = YoutubeSyncService.new(channel).sync!
      Rails.logger.info "YouTube sync [#{channel.name}]: #{result[:created]} new, #{result[:updated]} updated"
    else
      results = YoutubeSyncService.sync_all!
      results.each do |r|
        if r[:error]
          Rails.logger.warn "YouTube sync [#{r[:channel]}] failed: #{r[:error]}"
        else
          Rails.logger.info "YouTube sync [#{r[:channel]}]: #{r[:created]} new, #{r[:updated]} updated"
        end
      end
    end
  end
end
