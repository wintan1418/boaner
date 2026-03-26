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

    private

    def settings_params
      params.require(:site_setting).permit(
        :site_name, :tagline, :hero_heading, :hero_subheading,
        :bio_short, :bio_long, :email,
        :youtube_url, :twitter_url, :instagram_url, :linkedin_url,
        :profile_image, :hero_background
      )
    end
  end
end
