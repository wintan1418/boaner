class Lesson < ApplicationRecord
  belongs_to :course
  has_rich_text :body

  validates :title, presence: true

  scope :free_previews, -> { where(free_preview: true) }
end
