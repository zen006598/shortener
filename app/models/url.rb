class Url < ApplicationRecord
  validates :original, presence: true, format: URI::regexp(%w[http https])
  validates :slug, uniqueness: true

  before_validation :generate_slug
  
  def generate_slug
    self.slug = SecureRandom.uuid[0..5] if self.slug.nil?
  end
end
