class YoutubeSyncJob < ApplicationJob
  queue_as :default

  def perform
    settings = SiteSetting.instance
    return unless settings.youtube_auto_sync?

    result = YoutubeSyncService.new.sync!

    if result[:error]
      Rails.logger.warn "YouTube sync failed: #{result[:error]}"
    else
      Rails.logger.info "YouTube sync: #{result[:created]} created, #{result[:updated]} updated (#{result[:total]} total)"
    end
  end
end
