require 'open-uri'
require 'json'

Movie.destroy_all

(1..10).each do |num|
  url = "https://api.themoviedb.org/3/discover/movie?api_key=49da6ec6d7e005696bf13be889ab5bc9&sort_by=popularity.desc&page=#{num}"
  json = open(url).read
  objs = JSON.parse(json)

  objs["results"].each do |movie|
    Movie.create(title: movie["title"], year: movie["release_date"], rating: movie["vote_average"], plot: movie["overview"], genre: movie["genre_ids"])
  end
  puts "created page #{num}"
end
puts "seeded everything"

