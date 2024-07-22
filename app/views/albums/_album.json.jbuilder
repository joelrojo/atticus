json.extract! album, :id, :title, :release_date, :image_url, :slug
json.artist album.artist.name
json.genre album.genre.name