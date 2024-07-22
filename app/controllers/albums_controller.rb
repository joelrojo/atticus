class AlbumsController < ApplicationController
  before_action :set_album, only: [:show]

  def index
    @albums = Album.all
    render :index, formats: :json
  end

  def show
    render :show, formats: :json
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      if params[:album][:image].present?
        @album.image.attach(params[:album][:image])
      end
      render :show, status: :created, formats: :json
    else
      render json: @album.errors, status: :unprocessable_entity
    end
  end

  def update
    if @album.update(album_params)
      if params[:album][:image].present?
        @album.image.attach(params[:album][:image])
      end
      render :show, status: :ok, formats: :json
    else
      render json: @album.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @album.destroy
    head :no_content
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

  def album_params
    params.require(:album).permit(:title, :artist_id, :genre_id, :release_date, :image)
  end
end