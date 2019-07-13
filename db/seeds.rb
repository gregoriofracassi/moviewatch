require 'open-uri'
require 'json'

Movie.destroy_all

(1..200).each do |num|
  url = "https://api.themoviedb.org/3/discover/movie?api_key=49da6ec6d7e005696bf13be889ab5bc9&sort_by=popularity.desc&page=#{num}"
  json = open(url).read
  objs = JSON.parse(json)

  objs["results"].each do |movie|
    Movie.create(title: movie["title"], year: movie["release_date"], rating: movie["vote_average"], plot: movie["overview"])
  end
  puts "created page #{num}"
end
puts "seeded everything"

# {
#   "genres": [
#     {
#       "id": 28,
#       "name": "Action"
#     },
#     {
#       "id": 12,
#       "name": "Adventure"
#     },
#     {
#       "id": 16,
#       "name": "Animation"
#     },
#     {
#       "id": 35,
#       "name": "Comedy"
#     },
#     {
#       "id": 80,
#       "name": "Crime"
#     },
#     {
#       "id": 99,
#       "name": "Documentary"
#     },
#     {
#       "id": 18,
#       "name": "Drama"
#     },
#     {
#       "id": 10751,
#       "name": "Family"
#     },
#     {
#       "id": 14,
#       "name": "Fantasy"
#     },
#     {
#       "id": 36,
#       "name": "History"
#     },
#     {
#       "id": 27,
#       "name": "Horror"
#     },
#     {
#       "id": 10402,
#       "name": "Music"
#     },
#     {
#       "id": 9648,
#       "name": "Mystery"
#     },
#     {
#       "id": 10749,
#       "name": "Romance"
#     },
#     {
#       "id": 878,
#       "name": "Science Fiction"
#     },
#     {
#       "id": 10770,
#       "name": "TV Movie"
#     },
#     {
#       "id": 53,
#       "name": "Thriller"
#     },
#     {
#       "id": 10752,
#       "name": "War"
#     },
#     {
#       "id": 37,
#       "name": "Western"
#     }
#   ]
# }
