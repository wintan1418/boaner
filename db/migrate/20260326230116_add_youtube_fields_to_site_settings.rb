class AddYoutubeFieldsToSiteSettings < ActiveRecord::Migration[8.0]
  def change
    add_column :site_settings, :youtube_channel_id, :string
    add_column :site_settings, :youtube_api_key, :string
    add_column :site_settings, :youtube_auto_sync, :boolean
  end
end
