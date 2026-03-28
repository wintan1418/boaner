class AddYoutubeChannelToVideos < ActiveRecord::Migration[8.0]
  def change
    add_reference :videos, :youtube_channel, null: true, foreign_key: true
  end
end
