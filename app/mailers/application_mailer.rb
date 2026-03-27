class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch("MAILER_FROM", "hello@boaner.com")
  layout "mailer"
end
