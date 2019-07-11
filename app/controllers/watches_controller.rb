class WatchesController < ApplicationController
  def create
    @movie = Movie.find(params[:movie_id])
    @watch = Watch.new
    @watch.movie = @movie
    @watch.user = current_user
    @watch.save
    redirect_to movies_path
  end

end
