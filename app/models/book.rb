class Book < ApplicationRecord
  has_one_attached :cover

  validates :title, presence: true
end
