class PagesController < ApplicationController
  def set_top5
    @top5 = Movie.find(current_user.likes.where(top5: true).map { |like| like[:movie_id] })
    @liked3stars = Movie.find(current_user.likes.where(stars: 3, top5: false).map { |like| like[:movie_id] })
  end
end
