json.page params[:page].to_i > 0 ? params[:page].to_i : 1
json.per_page params[:per_page].to_i > 0 ? params[:per_page].to_i : 10
json.total_songs Song.count

json.songs do
  json.array! @songs, partial: 'songs/song', as: :song
end