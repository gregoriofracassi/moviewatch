class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @movies = @user.likes.where(stars: 3).order(:created_at).reverse.map { |like| Movie.find(like[:movie_id]) }
  end
end
