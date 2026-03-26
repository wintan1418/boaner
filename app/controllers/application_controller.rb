class ApplicationController < ActionController::Base
  allow_browser versions: :modern

  before_action :load_site_settings

  private

  def load_site_settings
    @settings = SiteSetting.instance
  end
end
