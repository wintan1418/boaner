module Admin
  class NewslettersController < BaseController
    def index
      @newsletters = Newsletter.recent
    end

    def new
      @newsletter = Newsletter.new
    end

    def create
      @newsletter = Newsletter.new(newsletter_params)
      if @newsletter.save
        redirect_to admin_newsletters_path, notice: "Newsletter draft saved."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @newsletter = Newsletter.find(params[:id])
      redirect_to admin_newsletters_path, alert: "Cannot edit a sent newsletter." if @newsletter.sent?
    end

    def update
      @newsletter = Newsletter.find(params[:id])
      if @newsletter.sent?
        redirect_to admin_newsletters_path, alert: "Cannot edit a sent newsletter."
      elsif @newsletter.update(newsletter_params)
        redirect_to admin_newsletters_path, notice: "Newsletter updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def send_newsletter
      @newsletter = Newsletter.find(params[:id])
      if @newsletter.sent?
        redirect_to admin_newsletters_path, alert: "Already sent."
      else
        subscriber_count = Subscriber.count
        NewsletterSendJob.perform_later(@newsletter.id)
        redirect_to admin_newsletters_path, notice: "Sending newsletter to #{subscriber_count} subscribers..."
      end
    end

    def destroy
      Newsletter.find(params[:id]).destroy
      redirect_to admin_newsletters_path, notice: "Newsletter deleted."
    end

    private

    def newsletter_params
      params.require(:newsletter).permit(:subject, :body)
    end
  end
end
