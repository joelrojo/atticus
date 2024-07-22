class Album < ApplicationRecord
  belongs_to :artist
  belongs_to :genre
  has_many :songs

  has_one_attached :image

  before_save :generate_slug

  validates :title, presence: true
  validates :release_date, presence: true

  private

  def generate_slug
    self.slug = title.parameterize
  end
end