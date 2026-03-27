class Newsletter < ApplicationRecord
  has_rich_text :body

  validates :subject, presence: true

  scope :sent, -> { where.not(sent_at: nil) }
  scope :drafts, -> { where(sent_at: nil) }
  scope :recent, -> { order(created_at: :desc) }

  def sent?
    sent_at.present?
  end

  def draft?
    sent_at.nil?
  end
end
