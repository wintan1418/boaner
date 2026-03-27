class NewsletterSendJob < ApplicationJob
  queue_as :default

  def perform(newsletter_id)
    newsletter = Newsletter.find(newsletter_id)
    return if newsletter.sent?

    subscribers = Subscriber.where(confirmed: [true, nil])
    count = 0

    subscribers.find_each do |subscriber|
      NewsletterMailer.broadcast(newsletter, subscriber).deliver_later
      count += 1
    end

    newsletter.update!(sent_at: Time.current, recipients_count: count)
  end
end
