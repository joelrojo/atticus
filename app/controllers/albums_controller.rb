class AlbumsController < ApplicationController
  before_action :set_album, only: [:show]

  def index
    @albums = Album.all
    render :index, formats: :json
  end

  def show
    render :show, formats: :json
  end

  def play
    # Return a list of songs in the album with their titles and mp3_urls
    songs = @album.songs.select(:id, :title, :mp3_url)
    render json: { message: "Playing album: #{@album.title}", songs: songs }, status: :ok
  end

  private

  def set_album
    @album = Album.find(params[:id])
  end
end