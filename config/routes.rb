Rails.application.routes.draw do

  resources :codes
  resources :bibtex_files
  resources :bibtex_entries
  resources :submissions
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
  post 'pandoc/pandoc_command', to: 'pandoc#pandoc_command', as: "pandoc_command"
  get 'pandoc/pandoc_convert/:stuff/:from/:to', to: 'pandoc#pandoc_convert', as: "pandoc_convert"
  get 'pandoc/pandoc_clean/:stuff/:from/:to', to: 'pandoc#pandoc_clean', as: "pandoc_clean"

  get '/bibtex_enter', to: 'bibtex#bibtex_enter', as: "bibtex_enter"
  get '/bibtex_create', to: 'bibtex#bibtex_create', as: "bibtex_create"
  post '/bibtex_create', to: 'bibtex#bibtex_create'

  get '/bibtex/bibtex_comma_seperated_list_of_bibtex_keys(/:text)', to: 'bibtex#bibtex_comma_seperated_list_of_bibtex_keys', as: "bibtex_comma_seperated_list_of_bibtex_keys"
  post '/bibtex/bibtex_comma_seperated_list_of_bibtex_keys(/:text)', to: 'bibtex#bibtex_comma_seperated_list_of_bibtex_keys', as: "bibtex_comma_seperated_list_of_bibtex_keys_post"

  get '/bibtex/bibtex_compare_bibtex_with_crossref(/:text)', to: 'bibtex#compare_bibtex_with_crossref', as: "bibtex_compare_bibtex_with_crossref"
  post '/bibtex/bibtex_compare_bibtex_with_crossref(/:text)', to: 'bibtex#compare_bibtex_with_crossref', as: "bibtex_compare_bibtex_with_crossref_post"

  get '/bibtex/bibtex_compare_author_bibtex_with_crossref(/:text)', to: 'bibtex#compare_author_bibtex_with_crossref', as: "bibtex_compare_author_bibtex_with_crossref"
  post '/bibtex/bibtex_compare_author_bibtex_with_crossref(/:text)', to: 'bibtex#compare_author_bibtex_with_crossref', as: "bibtex_compare_author_bibtex_with_crossref_post"

  post '/bibtex/bibtex_compare_author_bibtex_with_crossref_create', to: 'bibtex#compare_author_bibtex_with_crossref_create', as: "bibtex_compare_author_bibtex_with_crossref_create"

  get '/bibtex/bibtex_compare_author_bibtex_with_crossref_select/:array_of_bibtex_originals', to: 'bibtex#compare_author_bibtex_with_crossref_select', as: "bibtex_compare_author_bibtex_with_crossref_select"

  get '/editor/editor', to: "editor#editor", as: 'editor'
  post '/editor/editor', to: "editor#editor"

  get '/editor/basic_markdown_editor', to: "editor#basic_markdown_editor", as: "basic_markdown_editor"
  post '/editor/basic_markdown_editor', to: "editor#basic_markdown_editor", as: "basic_markdown_editor_post"

  get '/editor/pancritic_editor', to: "editor#pancritic_editor", as: "pancritic_editor"
  post '/editor/pancritic_editor', to: "editor#pancritic_editor", as: "pancritic_editor_post"

  get '/submission_pool', to: "submissions#pool", as: "submission_pool"
  post '/submissions_add_user_to_submission/:user_id/:submission_id', to: "submissions#add_user_to_submission", as: "submissions_add_user_to_submission"
end
