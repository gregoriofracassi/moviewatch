class LikesController < ApplicationController
  def create
    @movie = Movie.find(params[:movie_id])
    @like = Like.new(like_params)
    @like.movie = @movie
    @like.user = current_user
    raise
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

# a1 = [3, 4, 5, 6, 7]
# a2 = [3, 1, 2, 0, 9]
# puts (a1 & a2).empty?
