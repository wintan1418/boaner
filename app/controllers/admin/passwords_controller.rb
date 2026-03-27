module Admin
  class PasswordsController < ApplicationController
    layout "admin_login"

    # GET /admin/forgot-password
    def new
    end

    # POST /admin/forgot-password
    def create
      admin = AdminUser.find_by(email: params[:email])
      if admin
        token = admin.send_reset_password_instructions
        redirect_to admin_login_path, notice: "Password reset instructions sent to your email."
      else
        flash.now[:alert] = "No account found with that email."
        render :new, status: :unprocessable_entity
      end
    end

    # GET /admin/reset-password?reset_password_token=xxx
    def edit
      @token = params[:reset_password_token]
    end

    # PATCH /admin/reset-password
    def update
      admin = AdminUser.reset_password_by_token(
        reset_password_token: params[:reset_password_token],
        password: params[:password],
        password_confirmation: params[:password_confirmation]
      )

      if admin.errors.empty?
        redirect_to admin_login_path, notice: "Password updated. Please sign in."
      else
        @token = params[:reset_password_token]
        flash.now[:alert] = admin.errors.full_messages.join(", ")
        render :edit, status: :unprocessable_entity
      end
    end
  end
end
