class WatchesController < ApplicationController
  def create
    unless current_user.watches.where(movie_id: params[:movie_id]).exists?
      @movie = Movie.find(params[:movie_id])
      @watch = Watch.new
      @watch.movie = @movie
      @watch.user = current_user
      @watch.save
      redirect_to movies_path
    # else
    #   do something
    end
  end

end
