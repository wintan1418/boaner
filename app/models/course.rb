class Course < ApplicationRecord
  has_many :lessons, -> { order(position: :asc) }, dependent: :destroy

  validates :title, presence: true
  validates :slug, presence: true, uniqueness: true

  before_validation :generate_slug, on: :create

  scope :published, -> { where(published: true) }

  def to_param
    slug
  end

  private

  def generate_slug
    self.slug = title.to_s.parameterize if slug.blank?
  end
end
