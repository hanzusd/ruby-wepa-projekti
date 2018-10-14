Rails.application.routes.draw do
  resources :memberships
  resources :beer_clubs
  resources :users
  resources :beers
  resources :breweries
  resource :session, only: [:new, :create, :destroy]

  root 'breweries#index'

 # get 'ratings', to: 'ratings#index'
 # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 # get 'ratings/new', to:'ratings#new'
 # post 'ratings', to: 'ratings#create'
 get 'signup', to: 'users#new'
 get 'signin', to: 'sessions#new'
 delete 'signout', to: 'sessions#destroy'

 get 'places', to: 'places#index'
 post 'places', to:'places#search'

 resources :ratings, only: [:index, :new, :create, :destroy]

 resources :breweries do
  post 'toggle_activity', on: :member
 end

 resources :places, only: [:index, :show]
 # mikä generoi samat polut kuin seuraavat kaksi
 # get 'places', to:'places#index'
 # get 'places/:id', to:'places#show'

 post 'places', to:'places#search'

end
