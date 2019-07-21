class MoviesController < ApplicationController
  def index
    if current_user != nil
      if params[:query].present?
        @movies = Movie.search_by_title_and_year(params[:query]).page(params[:page])
      else
        @movies = Movie.order(:title).page(params[:page])
      end
        @watch = Watch.new
    else
      redirect_to new_user_session_path
    end
  end

  def show
    @movie = Movie.find(params[:id])
    @like = Like.new
  end

  def affiliate_users
    shared = []
    c_like_ids = current_user.likes.map { |like| like[:movie_id] }
    User.all.each do |user|
      shared_likes = (c_like_ids & user.likes.map { |like| like[:movie_id] }).size
      shared << { user: user, common_likes: shared_likes}
    end
    shared_ord = shared.sort_by { |elem| elem[:common_likes] }.reverse
    shared_ord.map { |obj| obj[:user] }
  end

  def watchable_movies
    watchable = []
    affiliate_users.each do |user|
      watchable << (user.watches.map { |watch| watch[:movie_id] }) - (current_user.watches.map { |watch| watch[:movie_id] })
    end
    @watchable_movies = watchable.flatten.uniq.map { |id| Movie.find(id) }
  end
end

