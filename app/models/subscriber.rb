class Subscriber < ApplicationRecord
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  before_create { self.subscribed_at = Time.current }
end
