class ContactMailer < ApplicationMailer
  def inquiry(name, email, subject, message)
    @name = name
    @email = email
    @subject = subject
    @message = message

    mail(
      to: Rails.application.config.contact_email || "admin@example.com",
      from: email,
      subject: "Contact: #{subject}"
    )
  end
end
