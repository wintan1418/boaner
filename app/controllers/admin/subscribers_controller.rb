module Admin
  class SubscribersController < BaseController
    def index
      @subscribers = Subscriber.order(created_at: :desc)
    end

    def destroy
      @subscriber = Subscriber.find(params[:id])
      @subscriber.destroy
      redirect_to admin_subscribers_path, notice: "Subscriber removed."
    end
  end
end
