# Clear existing data
User.destroy_all
Artist.destroy_all
Genre.destroy_all
Album.destroy_all
Song.destroy_all
Playlist.destroy_all

# Create Users
user1 = User.create!(email: 'user1@example.com', password: 'password')
user2 = User.create!(email: 'user2@example.com', password: 'password')

# Create Artists
artist1 = Artist.create!(name: 'Artist One')
artist2 = Artist.create!(name: 'Artist Two')

# Create Genres
genre1 = Genre.create!(name: 'Rock')
genre2 = Genre.create!(name: 'Pop')

# Create Albums
album1 = Album.create!(title: 'Album One', release_date: '2024-01-01', artist: artist1, genre: genre1)
album2 = Album.create!(title: 'Album Two', release_date: '2024-01-02', artist: artist2, genre: genre2)

# Create Songs
song1 = Song.create!(title: 'Song One', duration: 200, mp3_url: 'http://example.com/song1.mp3', artist: artist1, album: album1, genre: genre1)
song2 = Song.create!(title: 'Song Two', duration: 250, mp3_url: 'http://example.com/song2.mp3', artist: artist1, album: album1, genre: genre1)
song3 = Song.create!(title: 'Song Three', duration: 300, mp3_url: 'http://example.com/song3.mp3', artist: artist2, album: album2, genre: genre2)
song4 = Song.create!(title: 'Song Four', duration: 180, mp3_url: 'http://example.com/song4.mp3', artist: artist2, album: album2, genre: genre2)

# Create Playlists
playlist1 = Playlist.create!(name: 'Playlist One', description: 'A test playlist one', user: user1)
playlist2 = Playlist.create!(name: 'Playlist Two', description: 'A test playlist two', user: user2)

# Add Songs to Playlists
playlist1.songs << song1
playlist1.songs << song2
playlist2.songs << song3
playlist2.songs << song4

puts "Seed data created successfully!"