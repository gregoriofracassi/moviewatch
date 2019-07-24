class MoviesController < ApplicationController
  def index
    if current_user != nil
      if params[:query].present?
        @movies = Movie.search_by_title_and_year(params[:query]).page(params[:page])
      else
        @movies = watchable_movies.page(params[:page])
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

  def watchable_movies
    watchable = []
    affiliate_users.each do |obj|
      like_stars = []
      obj[:user].likes.each do |like|
        unless current_user.watches.map { |watch| watch[:movie_id] }.include?(like.movie_id)
          like_stars << { movie_id: like.movie_id, stars: like.stars }
        end
      end
      like_stars.each do |movie|
        watchable << { movie_id: movie[:movie_id], points: movie[:stars] * obj[:points] }
      end
    end
    record_sums = []
    watchable.each do |pair|
      x = pair[:movie_id]
      score = 0
      watchable.each do |record|
        score += record[:points] if record[:movie_id] == x
      end
      record_sums << { movie_id: pair[:movie_id], points: score }
    end
    ord_rec_sums = record_sums.sort_by { |elem| elem[:points] }.reverse
    @final_movs = ord_rec_sums.map { |mov| mov[:movie_id] }.uniq.map { |id| Movie.find(id) }
  end

  def affiliate_users
    @aff_users_scores = []
    User.all.each do |user|
      points = 0
      user.likes.each do |like|
        if current_user.likes.map { |lik| lik[:movie_id] }.include?(like[:movie_id])
          if (like.stars - current_user.likes.where(movie_id: like.movie_id)[0].stars).abs == 2
            points += 1
          elsif (like.stars - current_user.likes.where(movie_id: like.movie_id)[0].stars).abs == 1
            points += 2
          elsif (like.stars - current_user.likes.where(movie_id: like.movie_id)[0].stars).abs == 0
            points += 3
          end
        end
      end
      @aff_users_scores << { user: user, points: points }
    end
    @aff_users_scores
  end
end

