class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true

  validates :name, presence: true
  validates :body, presence: true

  scope :approved, -> { where(approved: true) }
  scope :pending, -> { where(approved: false) }
end
