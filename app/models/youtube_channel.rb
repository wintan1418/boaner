class YoutubeChannel < ApplicationRecord
  has_many :videos, dependent: :nullify

  validates :name, presence: true
  validates :channel_id, presence: true, uniqueness: true

  scope :auto_syncable, -> { where(auto_sync: true) }
end
