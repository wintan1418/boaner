class CreateYoutubeChannels < ActiveRecord::Migration[8.0]
  def change
    create_table :youtube_channels do |t|
      t.string :name
      t.string :channel_id
      t.string :api_key
      t.boolean :auto_sync
      t.datetime :last_synced_at

      t.timestamps
    end
  end
end
