class Genre < ApplicationRecord
  has_many :albums
  has_many :songs

  before_save :generate_slug

  validates :name, presence: true, uniqueness: true

  private

  def generate_slug
    self.slug = name.parameterize
  end
end