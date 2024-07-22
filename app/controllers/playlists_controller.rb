class PlaylistsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_playlist, only: [:show, :update, :destroy, :play, :add_song, :remove_song]
  before_action :authorize_user!, only: [:update, :destroy, :add_song, :remove_song]

  def index
    @playlists = current_user.playlists
    render :index, formats: :json
  end

  def show
    render :show, formats: :json
  end

  def create
    @playlist = current_user.playlists.new(playlist_params)
    if @playlist.save
      render :show, status: :created, formats: :json
    else
      render json: @playlist.errors, status: :unprocessable_entity
    end
  end

  def update
    if @playlist.update(playlist_params)
      render :show, status: :ok, formats: :json
    else
      render json: @playlist.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @playlist.destroy
    head :no_content
  end

  def add_song
    song = Song.find(params[:song_id])
    if @playlist.songs.include?(song)
      render json: { error: 'Song already in playlist' }, status: :unprocessable_entity
    else
      @playlist.songs << song
      render :show, status: :ok, formats: :json
    end
  end

  def remove_song
    song = Song.find(params[:song_id])
    if @playlist.songs.include?(song)
      @playlist.songs.delete(song)
      render :show, status: :ok, formats: :json
    else
      render json: { error: 'Song not in playlist' }, status: :unprocessable_entity
    end
  end

  def play
    # Return a list of songs in the playlist with their titles and mp3_urls
    songs = @playlist.songs.select(:id, :title, :mp3_url)
    render json: { message: "Playing playlist: #{@playlist.name}", songs: songs }, status: :ok
  end

  private

  def set_playlist
    @playlist = Playlist.find(params[:id])
  end

  def authorize_user!
    render json: { error: 'Unauthorized' }, status: :unauthorized unless @playlist.user == current_user
  end

  def playlist_params
    params.require(:playlist).permit(:name, :description)
  end
end