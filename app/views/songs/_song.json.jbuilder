json.extract! song, :id, :title, :duration, :image_url, :mp3_url, :slug
json.artist song.artist.name
json.album song.album.title
json.genre song.genre.name