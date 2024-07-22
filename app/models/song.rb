class Song < ApplicationRecord
  belongs_to :artist
  belongs_to :album
  belongs_to :genre
  has_many :playlist_songs
  has_many :playlists, through: :playlist_songs

  before_save :generate_slug

  validates :title, presence: true
  validates :duration, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :mp3_url, presence: true

  private

  def generate_slug
    self.slug = title.parameterize
  end
end