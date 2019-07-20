class Movie < ApplicationRecord
  has_many :likes
  has_many :watches
  has_many :users, through: :likes
  has_many :users, through: :watches

  serialize :genre, Array

  paginates_per 15

  include PgSearch
  pg_search_scope :search_by_title_and_year,
    against: [ :title, :year ],
    using: {
      tsearch: { prefix: true }
    }
  def genre_name
    genre.map do |num|
      case num
      when 28
        "Action"
      when 12
        "Adventure"
      when 16
        "Animation"
      when 35
        "Comedy"
      when 80
        "Crime"
      when 99
        "Documentary"
      when 18
        "Drama"
      when 10751
        "Family"
      when 14
        "Fantasy"
      when 36
        "History"
      when 27
        "Horror"
      when 10402
        "Music"
      when 9648
        "Mystery"
      when 10749
        "Romance"
      when 878
        "Science Fiction"
      when 10770
        "TV Movie"
      when 53
        "Thriller"
      when 10752
        "War"
      when 37
        "Western"
      end
    end
  end
end

