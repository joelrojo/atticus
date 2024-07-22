class Playlist < ApplicationRecord
  belongs_to :user
  has_many :playlist_songs
  has_many :songs, through: :playlist_songs

  before_save :generate_slug

  validates :name, presence: true

  private

  def generate_slug
    self.slug = name.parameterize
  end
end