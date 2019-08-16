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
  get '/movies/:id/maketop', to: 'likes#make_top5', as: 'make_top'
  get '/movies/:id/undotop', to: 'likes#undo_top5', as: 'undo_top'
end
