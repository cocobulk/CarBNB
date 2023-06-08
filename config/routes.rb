Rails.application.routes.draw do
  devise_for :users
  root to: "cars#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :cars do
    resources :bookings, only: [:new, :create]
  end

  resources :bookings, only: [:index, :show, :edit, :update, :destroy]

  get "dashboard", to: "pages#dashboard"
  get "dashboard/show/:id", to: "cars#showmycar", as: "show_my_car"

  resources :bookings do
    member do
      post :approve
    end
  end
  # Defines the root path route ("/")
  # root "articles#index"
  resources :cars, only: :index
end
