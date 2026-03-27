class ContactMessage < ApplicationRecord
  validates :name, :email, :message, presence: true

  scope :unread, -> { where(read: false) }
  scope :recent, -> { order(created_at: :desc) }

  before_create { self.read = false if read.nil? }
end
