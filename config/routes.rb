Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'movies#index'

  resources :movies do
    resources :watches, :likes
  end

  get '/afusers', to: "movies#affiliate_users", as: 'affiliate_users'
end
