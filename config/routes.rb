Rails.application.routes.draw do

  resources :blog_posts
  resources :articles

  get 'articles/:id/latex', to: 'articles#latex', as: "article_latex"

  devise_for :users
  root 'static_pages#welcome'

  resources :pages

  get '/about-us', to: 'pages#show', id: "about-us"
  get '/dashboard', to: 'static_pages#dashboard', as: "dashboard"

end
