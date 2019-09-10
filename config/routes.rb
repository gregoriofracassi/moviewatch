Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'movies#index'

  resources :movies do
    resources :watches, :likes
  end

  resources :users, only: [:show]

  get '/simusers', to: 'movies#affiliate_users', as: 'affiliate_users'
  get '/watchmovies', to: 'movies#watchable_movies', as: 'watchable_movies'
  get '/movies/:movie_id/maketop', to: 'likes#make_top5', as: 'make_top'
  get '/movies/:movie_id/undotop', to: 'likes#undo_top5', as: 'undo_top'
  get '/pages/settop', to: 'pages#set_top5', as: 'top_5'
end

# quando una richiesta http è fatta passando un id nestante, sarà esso nei params.
# Quando si fa una richiesta con id nestante? quando la route lo richiede
