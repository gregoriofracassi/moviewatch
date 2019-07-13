class MoviesController < ApplicationController
  def index
    if current_user != nil
      @movies = Movie.order(:title).page(params[:page])
      @watch = Watch.new
    else
      redirect_to new_user_session_path
    end
  end
  def show
    @movie = Movie.find(params[:id])
    @like = Like.new
  end
end

