module Admin
  class ContactMessagesController < BaseController
    def index
      @messages = ContactMessage.recent
      @unread_count = ContactMessage.unread.count
    end

    def show
      @message = ContactMessage.find(params[:id])
      @message.update(read: true) unless @message.read?
    end

    def destroy
      ContactMessage.find(params[:id]).destroy
      redirect_to admin_contact_messages_path, notice: "Message deleted."
    end
  end
end
