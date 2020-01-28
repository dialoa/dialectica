Rails.application.routes.draw do

  devise_for :users
  root 'static_pages#welcome'

  resources :pages

  get '/about-us', to: 'pages#show', id: "about-us"
  get '/dashboard', to: 'static_pages#dashboard', as: "dashboard"

end
