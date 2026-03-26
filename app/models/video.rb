class Video < ApplicationRecord
  belongs_to :series, optional: true
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

  def related_videos(limit = 3)
    Video.published.where(category: category).where.not(id: id).limit(limit)
  end
end
