class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @movies = Movie.find(@user.likes.where(top5: true).map { |like| like[:movie_id] })
  end

  def watchable_movies_from_movies
    movies_controller = MoviesController.new
    movies_controller.request = request
    movies_controller.response = response
    movies_controller.watchable_movies
  end

  def top_five
    watchable_movies_from_movies.sort_by { |el| el[:created_at] }.reverse
  end
end

