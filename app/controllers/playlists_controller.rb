class PlaylistsController < ApplicationController
  before_action :set_playlist, only: [:show, :update, :destroy, :play, :add_song, :remove_song]

  def index
    @playlists = Playlist.all # Adjusted to get all playlists since we're not using current_user
    render :index, formats: :json
  end

  def show
    render :show, formats: :json
  end

  def create
    # Assign to a default user for now, replace with appropriate user logic
    @playlist = Playlist.new(playlist_params)
    @playlist.user = User.first || User.create!(email: 'default@example.com', password: 'password')

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
    songs = @playlist.songs.select(:id, :title, :mp3_url)
    render json: { message: "Playing playlist: #{@playlist.name}", songs: songs }, status: :ok
  end

  private

  def set_playlist
    @playlist = Playlist.find(params[:id])
  end

  def playlist_params
    params.require(:playlist).permit(:name, :description)
  end
end
