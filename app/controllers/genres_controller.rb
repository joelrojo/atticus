class GenresController < ApplicationController
  before_action :set_genre, only: [:show]

  def index
    @genres = Genre.all
    render :index, formats: :json
  end

  def show
    render :show, formats: :json
  end

  private

  def set_genre
    @genre = Genre.find(params[:id])
  end
end