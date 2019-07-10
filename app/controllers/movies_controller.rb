class MoviesController < ApplicationController
  def index
    @movies = Movie.order(:title).page(params[:page])
  end
end
