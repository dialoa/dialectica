Rails.application.routes.draw do

  resources :stuffs
  resources :issues
  resources :blog_posts
  resources :articles

  get 'articles/:id/latex', to: 'articles#latex', as: "article_latex"
  get 'articles/:id/pdf', to: 'articles#pdf', as: "article_pdf"
  get 'articles/:id/plain', to: 'articles#plain', as: "article_plain"
  get 'articles/:id/markdown', to: 'articles#markdown', as: "article_markdown"

  devise_for :users
  root 'static_pages#welcome'

  resources :pages

  get '/about-us', to: 'pages#show', id: "about-us"
  get '/dashboard', to: 'static_pages#dashboard', as: "dashboard"
  get '/bibtex', to: 'static_pages#bibtex', as: "bibtex"

  get '/pandoc', to: 'pandoc#pandoc', as: "pandoc"
  post 'pandoc/pandoc_output', to: 'pandoc#pandoc_output', as: "pandoc_output"
  post 'pandoc/pandoc_clean', to: 'pandoc#pandoc_clean', as: "pandoc_clean"

end
