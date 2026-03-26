class Post < ApplicationRecord
  has_rich_text :body
  has_many :comments, as: :commentable, dependent: :destroy

  validates :title, presence: true
  validates :slug, presence: true, uniqueness: true

  before_validation :generate_slug, on: :create

  scope :featured, -> { where(featured: true) }
  scope :published, -> { where("published_at <= ?", Time.current).order(published_at: :desc) }
  scope :by_category, ->(cat) { where(category: cat) if cat.present? }

  def to_param
    slug
  end

  def reading_time
    words = body.to_plain_text.split.size
    minutes = (words / 200.0).ceil
    "#{minutes} min read"
  end

  def related_posts(limit = 3)
    Post.published.where(category: category).where.not(id: id).limit(limit)
  end

  private

  def generate_slug
    self.slug = title.to_s.parameterize if slug.blank?
  end
end
