json.extract! album, :id, :title, :release_date, :slug
json.artist album.artist.name
json.genre album.genre.name
json.image_url url_for(album.image) if album.image.attached?