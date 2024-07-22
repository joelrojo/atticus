class AlbumsController < ApplicationController
  before_action :set_album, only: [:show]

  def index
    @albums = Album.all
    render :index, formats: :json
  end

  def show
    render :show, formats: :json
  end

  private

  def set_album
    @album = Album.find(params[:id])
  end
end