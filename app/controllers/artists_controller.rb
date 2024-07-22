class ArtistsController < ApplicationController
  before_action :set_artist, only: [:show]

  def index
    @artists = Artist.all
    render :index, formats: :json
  end

  def show
    render :show, formats: :json
  end

  private

  def set_artist
    @artist = Artist.find(params[:id])
  end
end