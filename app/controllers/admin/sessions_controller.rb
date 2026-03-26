module Admin
  class SessionsController < ApplicationController
    layout "admin"
    before_action :redirect_if_authenticated, only: [ :new, :create ]

    def new
    end

    def create
      admin = AdminUser.find_by(email: params[:email])
      if admin&.valid_password?(params[:password])
        session[:admin_id] = admin.id
        redirect_to admin_root_path, notice: "Welcome back!"
      else
        flash.now[:alert] = "Invalid email or password."
        render :new, status: :unprocessable_entity
      end
    end

    def destroy
      session.delete(:admin_id)
      redirect_to admin_login_path, notice: "Signed out successfully."
    end

    private

    def redirect_if_authenticated
      if session[:admin_id] && AdminUser.exists?(session[:admin_id])
        redirect_to admin_root_path
      end
    end
  end
end
