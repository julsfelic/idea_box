Rails.application.routes.draw do
  root to: 'static_pages#home'

  resources :users, only: [:new, :create, :show]

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
end
