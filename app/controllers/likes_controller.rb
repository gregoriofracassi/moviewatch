class LikesController < ApplicationController
  def create
    raise
    unless current_user.likes.where(movie_id: params[:movie_id]).exists?
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
    # else
    #   do something
    end
  end

  def make_top5
    x = current_user.likes.where(movie_id: params[:id])[0]
    x.top5 = true
    x.save
    redirect_to movie_path(Movie.find(params[:id]))
  end

  def undo_top5
    x = current_user.likes.where(movie_id: params[:id])
    x.top5 = false
    x.save
  end

  private

  def like_params
    params.require(:like).permit(:stars)
  end
end

