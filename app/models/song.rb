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

  def self.songs_by_artist_and_genre(artist_id, genre_id)
    find_by_sql([<<-SQL, artist_id, genre_id])
      SELECT songs.*
      FROM songs
      JOIN albums ON albums.id = songs.album_id
      WHERE songs.artist_id = ? AND songs.genre_id = ?
      ORDER BY albums.release_date
    SQL
  end

  private

  def generate_slug
    self.slug = title.parameterize
  end
end