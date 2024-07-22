json.extract! playlist, :id, :name, :description
json.songs playlist.songs do |song|
  json.extract! song, :id, :title
  json.artist song.artist.name
  json.album song.album.title
end