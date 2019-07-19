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


    # if params[:query].present?
    #   @houses = House.search_by_address(params[:query])
    # else
    #   @houses = House.where.not(latitude: nil, longitude: nil).order(created_at: :desc)

