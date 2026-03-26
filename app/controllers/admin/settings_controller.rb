module Admin
  class SettingsController < BaseController
    def edit
      @settings = SiteSetting.instance
    end

    def update
      @settings = SiteSetting.instance
      if @settings.update(settings_params)
        redirect_to edit_admin_settings_path, notice: "Settings updated successfully."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def sync_youtube
      result = YoutubeSyncService.new.sync!

      if result[:error]
        redirect_to edit_admin_settings_path, alert: "Sync failed: #{result[:error]}"
      else
        redirect_to edit_admin_settings_path, notice: "YouTube sync complete! #{result[:created]} new, #{result[:updated]} updated."
      end
    end

    private

    def settings_params
      params.require(:site_setting).permit(
        :site_name, :tagline, :hero_heading, :hero_subheading,
        :bio_short, :bio_long, :email,
        :youtube_url, :twitter_url, :instagram_url, :linkedin_url,
        :youtube_channel_id, :youtube_api_key, :youtube_auto_sync,
        :profile_image, :hero_background
      )
    end
  end
end
