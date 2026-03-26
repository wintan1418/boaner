class SubscribersController < ApplicationController
  def create
    @subscriber = Subscriber.new(email: params[:email])

    respond_to do |format|
      if @subscriber.save
        format.turbo_stream
        format.html { redirect_back fallback_location: root_path, notice: "Subscribed!" }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("newsletter_form", partial: "subscribers/form", locals: { subscriber: @subscriber }) }
        format.html { redirect_back fallback_location: root_path, alert: @subscriber.errors.full_messages.join(", ") }
      end
    end
  end
end
