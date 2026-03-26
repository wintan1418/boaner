class Video < ApplicationRecord
  has_many :comments, as: :commentable, dependent: :destroy

  validates :title, presence: true
  validates :youtube_id, presence: true, uniqueness: true

  scope :featured, -> { where(featured: true) }
  scope :published, -> { where("published_at <= ?", Time.current).order(published_at: :desc) }
  scope :by_category, ->(cat) { where(category: cat) if cat.present? }

  def thumbnail_url
    "https://img.youtube.com/vi/#{youtube_id}/maxresdefault.jpg"
  end

  def thumbnail_url_hq
    "https://img.youtube.com/vi/#{youtube_id}/hqdefault.jpg"
  end

  def embed_url
    "https://www.youtube.com/embed/#{youtube_id}"
  end
end
