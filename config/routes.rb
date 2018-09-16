Rails.application.routes.draw do
  resources :beers
  resources :breweries

  root 'breweries#index'

  get 'ratings', to: 'ratings#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'ratings/new', to:'ratings#new'
  post 'ratings', to: 'ratings#create'

end