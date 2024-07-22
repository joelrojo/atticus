class SongsController < ApplicationController
  before_action :set_song, only: [:show, :play, :destroy]

  def index
    @songs = Song.all
    render :index, formats: :json
  end

  def show
    render :show, formats: :json
  end

  def create
    @song = Song.new(song_params)
    if @song.save
      render :show, status: :created, formats: :json
    else
      render json: @song.errors, status: :unprocessable_entity
    end
  end

  def play
    # logic to play the song
    render json: { message: "Playing song #{@song.title}" }
  end

  # !! might not be needed since users can't delete songs
  def destroy
    @song.destroy
    head :no_content
  end

  private

  def set_song
    @song = Song.find(params[:id])
  end

  def song_params
    params.require(:song).permit(:title, :duration, :artist_id, :album_id, :genre_id, :image_url, :mp3_url)
  end
end