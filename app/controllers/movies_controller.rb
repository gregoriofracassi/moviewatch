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
end

# shared = []
# User.all.each do |user|
#   shared_likes = (user.likes & current_user.likes).size
#   user_likes_hash = Hash.new
#   user_likes_hash[:user] = user
#   user_likes_hash[:common_likes] = shared_likes
#   shared << user_likes_hash
# end
# shared_ord = shared.sort_by { |elem| elem[:common_likes] }
# sim_shared = shared_ord[0..5]
# sim_shared.map { |obj| obj[:user] }
