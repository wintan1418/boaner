module Admin
  class BaseController < ApplicationController
    layout "admin"
    before_action :authenticate_admin!

    private

    def authenticate_admin!
      unless current_admin
        redirect_to admin_login_path, alert: "Please sign in to continue."
      end
    end

    def current_admin
      @current_admin ||= AdminUser.find_by(id: session[:admin_id]) if session[:admin_id]
    end
    helper_method :current_admin
  end
end
