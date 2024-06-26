Rails.application.routes.draw do
  root to: "pages#home"

  devise_for :users
  resources :user_ingredients, only: [:new, :create, :edit, :update, :destroy]
  resources :recipes, only: [:index, :show] do
    resources :favourites, only: [:index, :create]
    collection do
      post :update_search_results
      get :favourites
    end
  end
  resources :favourites, only: [:destroy]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
