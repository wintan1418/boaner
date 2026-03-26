class PagesController < ApplicationController
  def about
  end

  def contact
  end

  def send_message
    @name = params[:name]
    @email = params[:email]
    @subject = params[:subject]
    @message = params[:message]

    if @name.present? && @email.present? && @message.present?
      ContactMailer.inquiry(@name, @email, @subject, @message).deliver_later
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to contact_path, notice: "Message sent successfully!" }
      end
    else
      flash.now[:alert] = "Please fill in all required fields."
      render :contact, status: :unprocessable_entity
    end
  end
end
