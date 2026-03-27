class NewsletterMailer < ApplicationMailer
  def broadcast(newsletter, subscriber)
    @newsletter = newsletter
    @subscriber = subscriber
    @settings = SiteSetting.instance

    mail(
      to: subscriber.email,
      subject: newsletter.subject
    )
  end
end
