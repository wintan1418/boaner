namespace :youtube do
  desc "Sync videos from YouTube channel"
  task sync: :environment do
    result = YoutubeSyncService.new.sync!

    if result[:error]
      puts "Error: #{result[:error]}"
    else
      puts "Synced #{result[:total]} videos (#{result[:created]} new, #{result[:updated]} updated)"
    end
  end
end
