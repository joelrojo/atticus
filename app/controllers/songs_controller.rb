class SongsController < ApplicationController
  before_action :set_song, only: [:show, :play, :destroy]

  def index
    # Pagination logic would apply to other models as well
    page = params[:page].to_i > 0 ? params[:page].to_i : 1
    per_page = params[:per_page].to_i > 0 ? params[:per_page].to_i : 10
    offset = (page - 1) * per_page

    @songs = Song.limit(per_page).offset(offset)

    if params[:genre_id]
      @songs = @songs.where(genre_id: params[:genre_id])
    elsif params[:artist_id]
      @songs = @songs.where(artist_id: params[:artist_id])
    elsif params[:album_id]
      @songs = @songs.where(album_id: params[:album_id])
    end
    
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

  # !! might not need this since you can get mp3_url from show endpoint
  def play
    render json: { message: "Playing song: #{@song.title}", mp3_url: @song.mp3_url }, status: :ok
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