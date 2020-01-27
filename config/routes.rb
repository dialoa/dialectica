Rails.application.routes.draw do

  root 'static_pages#welcome'


  resources :pages, path: ''

end
