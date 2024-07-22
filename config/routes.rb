Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :users, only: [:index, :show, :update, :destroy]
  resources :artists, only: [:index, :show]
  resources :genres, only: [:index, :show]
  resources :albums, only: [:index, :show] do
    member do
      post :play
    end
  end
  resources :songs, only: [:index, :show, :create, :destroy] do
    member do
      post :play
    end
  end
  resources :playlists, only: [:index, :show, :create, :update, :destroy] do
    member do
      post :play
      post :add_song
      delete :remove_song
    end
  end
end
