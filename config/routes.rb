Rails.application.routes.draw do

  resources :blog_posts
  resources :articles

  get 'articles/:id/latex_code', to: 'articles#latex_code', as: "article_latex_code"

  devise_for :users
  root 'static_pages#welcome'

  resources :pages

  get '/about-us', to: 'pages#show', id: "about-us"
  get '/dashboard', to: 'static_pages#dashboard', as: "dashboard"

end
