class LikesController < ApplicationController
  def create
    @movie = Movie.find(params[:movie_id])
    @like = Like.new(like_params)
    @like.movie = @movie
    @like.user = current_user
    @like.save

    return unless (@movie.watches & current_user.watches).empty?

    @watch = Watch.new
    @watch.movie = @movie
    @watch.user = current_user
    @watch.save
  end

  private

  def like_params
    params.require(:like).permit(:stars)
  end
end

