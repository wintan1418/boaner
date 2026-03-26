class Series < ApplicationRecord
  has_many :videos, -> { order(published_at: :asc) }, dependent: :nullify
  validates :title, presence: true
  validates :slug, presence: true, uniqueness: true
  before_validation :generate_slug, on: :create

  def to_param
    slug
  end

  private
  def generate_slug
    self.slug = title.to_s.parameterize if slug.blank?
  end
end
