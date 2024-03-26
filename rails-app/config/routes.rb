Rails.application.routes.draw do

  resources :web_site_contents
  resources :question_answers do
    member do
      put "answer_question"
    end
  end
  resources :media do
    member do

    end
    collection do
      post "create_for_submission"
    end
  end
  resources :email_templates
  get 'test/destroy_all_submissions'
  get 'test/destroy_all_users'
  get 'test/destroy_all_external_referees'
  get 'test/get_json_from_all_submissions'
  get 'test/generate_fake_submissions_and_jsons'

  #get 'users/user_overview'
  #resources :users
  resources :user do
    collection do
      get 'user_overview'
      get 'dashboard'

    end
    member do
      get 'show_user'
      get 'edit_user'
      put 'update_user'
      put 'add_role_to_user'
      put 'remove_role_from_user'
    end
  end

  resources :submissions do
    member do
      put 'propose_for_acceptance'
      put 'propose_for_rejection'
      put 'unpropose_for_acceptance'
      put 'unpropose_for_rejection'
      put 'withdraw_submission'
      put 'undo_withdraw_submission'
      get 'show_for_user'
      get 'resubmit_submission'
      get 'send_rejection_to_author_form'
      put 'send_rejection_to_author'
      put 'propose_for_discussion'
      put 'unpropose_for_discussion'
      put 'prolong_life'
    end
    collection do
      get 'iframe_new'
      get 'submission_was_successful'
      get 'my_submissions'
      get 'searchable_list'
      get 'searchable_cards'
      get 'submission_list'
    end
  end

  get 'submission/:dialectica_id', to: "submissions#submission", as: "submission_dialectica_id"


  #   post '/external_referee_submission_tools/select_external_referee_for_form', to: "external_referee_submissions#select_external_referee_for_form", as: "select_external_referee_for_form"
  resources :external_referee_submissions do
    collection do
      post 'select_external_referee_for_form', as: "select_external_referee_for_form"
      get 'send_to_external_referee/:submission_id', to: 'external_referee_submissions#send_to_external_referee', as: "send_to_external_referee"
    end
  end
  resources :external_referees
  resources :requested_reviewers
  get 'tools/enter_doi_page', to: 'tools#enter_doi_page', as: "enter_doi_page"
  get 'tools/get_data_from_crossref_with_doi', to: 'tools#get_data_from_crossref_with_doi', as: "get_data_from_crossref_with_doi"
  post 'tools/get_multiple_data_from_crossref_with_dois', to: 'tools#get_multiple_data_from_crossref_with_dois', as: "get_multiple_data_from_crossref_with_dois"

  get 'tools/csv', to: 'tools#csv', as: "tools_csv"
  post 'tools/csv', to: 'tools#csv'
  resources :blocked_users
  resources :histories do
    collection do
      get 'searchable_list_histories'
    end
  end
  resources :reports
  resources :jsons
  resources :codes
  resources :bibtex_files
  resources :bibtex_entries

  resources :stuffs
  resources :issues
  resources :blog_posts
  resources :articles

  get 'articles/:id/latex', to: 'articles#latex', as: "article_latex"
  get 'articles/:id/pdf', to: 'articles#pdf', as: "article_pdf"
  get 'articles/:id/plain', to: 'articles#plain', as: "article_plain"
  get 'articles/:id/markdown', to: 'articles#markdown', as: "article_markdown"

  devise_for :users

  #root "submissions#pool"
  #root 'static_pages#welcome'
  root 'pages#welcome'

  resources :pages do
    collection do
      post 'update_order'
    end
  end

  get '/about-us', to: 'pages#show', id: "about-us"
  get '/dashboard', to: 'static_pages#dashboard', as: "dashboard"
  get '/dashboard2', to: 'static_pages#dashboard2', as: "dashboard2"
  get '/bibtex', to: 'static_pages#bibtex', as: "bibtex"
  get '/submission_welcome', to: 'static_pages#submission_welcome', as: "submission_welcome"
  get '/welcome_user', to: 'static_pages#welcome_user', as: "welcome_user"


  get '/pandoc', to: 'pandoc#pandoc', as: "pandoc"
  post 'pandoc/pandoc_command', to: 'pandoc#pandoc_command', as: "pandoc_command"
  get 'pandoc/pandoc_convert/:stuff/:from/:to', to: 'pandoc#pandoc_convert', as: "pandoc_convert"
  get 'pandoc/pandoc_clean/:stuff/:from/:to', to: 'pandoc#pandoc_clean', as: "pandoc_clean"
  post 'pandoc/pandoc_reconvert/', to: 'pandoc#pandoc_reconvert', as: "pandoc_reconvert"

  get '/bibtex_enter', to: 'bibtex#bibtex_enter', as: "bibtex_enter"
  get '/bibtex_create', to: 'bibtex#bibtex_create', as: "bibtex_create"
  post '/bibtex_create', to: 'bibtex#bibtex_create'

  get "/bibtex_tools/replace_underscore", to: "bibtex#replace_underscore", as: "replace_underscore"
  post "/bibtex_tools/replace_underscore", to: "bibtex#replace_underscore"

  get "/bibtex_tools/squish_bibtex_file", to: "bibtex#squish_bibtex_file", as: "squish_bibtex_file"
  post "/bibtex_tools/squish_bibtex_file_execute", to: "bibtex#squish_bibtex_file_execute", as: "squish_bibtex_file_execute"

  post "/bibtex_tools/replace_underscore_forwards", to: "bibtex#replace_underscore_forwards", as: "replace_underscore_forwards"
  post "/bibtex_tools/replace_underscore_backwards", to: "bibtex#replace_underscore_backwards", as: "replace_underscore_backwards"

  get '/bibtex/bibtex_comma_seperated_list_of_bibtex_keys(/:text)', to: 'bibtex#bibtex_comma_seperated_list_of_bibtex_keys', as: "bibtex_comma_seperated_list_of_bibtex_keys"
  post '/bibtex/bibtex_comma_seperated_list_of_bibtex_keys(/:text)', to: 'bibtex#bibtex_comma_seperated_list_of_bibtex_keys', as: "bibtex_comma_seperated_list_of_bibtex_keys_post"

  get '/bibtex/get_bib_from_biblio(/:text)', to: 'bibtex#get_bib_from_biblio', as: "bibtex_get_bib_from_biblio"
  post '/bibtex/get_bib_from_biblio(/:text)', to: 'bibtex#get_bib_from_biblio', as: "bibtex_get_bib_from_biblio_post"

  get '/bibtex/get_dialectica_articles_from_crossref', to: "bibtex#get_dialectica_articles_from_crossref", as: "get_dialectica_articles_from_crossref"

  get '/bibtex/bibtex_compare_bibtex_with_crossref(/:text)', to: 'bibtex#compare_bibtex_with_crossref', as: "bibtex_compare_bibtex_with_crossref"
  post '/bibtex/bibtex_compare_bibtex_with_crossref(/:text)', to: 'bibtex#compare_bibtex_with_crossref', as: "bibtex_compare_bibtex_with_crossref_post"

  get '/bibtex/bibtex_compare_author_bibtex_with_crossref(/:text)', to: 'bibtex#compare_author_bibtex_with_crossref', as: "bibtex_compare_author_bibtex_with_crossref"
  post '/bibtex/bibtex_compare_author_bibtex_with_crossref(/:text)', to: 'bibtex#compare_author_bibtex_with_crossref', as: "bibtex_compare_author_bibtex_with_crossref_post"

  #get '/bibtex/bibtex_compare_author_bibtex_with_crossref(/:text)', to: 'bibtex#compare_author_bibtex_with_crossref', as: "bibtex_compare_author_bibtex_with_crossref"

  post '/bibtex/bibtex_compare_author_bibtex_with_crossref_create', to: 'bibtex#compare_author_bibtex_with_crossref_create', as: "bibtex_compare_author_bibtex_with_crossref_create"

  get '/bibtex/bibtex_compare_author_bibtex_with_crossref_select/:format_type/:array_of_originals/', to: 'bibtex#compare_author_bibtex_with_crossref_select', as: "bibtex_compare_author_bibtex_with_crossref_select"

  get '/editor/editor', to: "editor#editor", as: 'editor'
  post '/editor/editor', to: "editor#editor"

  get '/editor/basic_markdown_editor', to: "editor#basic_markdown_editor", as: "basic_markdown_editor"
  post '/editor/basic_markdown_editor', to: "editor#basic_markdown_editor", as: "basic_markdown_editor_post"

  get '/editor/pancritic_editor', to: "editor#pancritic_editor", as: "pancritic_editor"
  post '/editor/pancritic_editor', to: "editor#pancritic_editor", as: "pancritic_editor_post"


  get '/submission_panel/:id', to: "submissions#panel", as: "submission_panel"
  get '/submission_pool', to: "submissions#pool", as: "submission_pool"
  get '/submission_tools/show_pool/:id', to: "submissions#show_pool", as: "submission_show_pool"
  post '/submissions_add_user_to_submission/:user_id/:submission_id', to: "submissions#add_user_to_submission", as: "submissions_add_user_to_submission"
  post '/submissions_remove_user_from_submission/:user_id/:submission_id', to: "submissions#remove_user_from_submission", as: "submissions_remove_user_from_submission"
  post '/submission_tools/create_suggestion_to_user/', to: "submissions#create_suggestion_to_user", as: "submissions_create_suggestion_to_user"

  post '/submission_tools/send_to_external_referee/:submission_id', to: "submissions#send_to_external_referee", as: "submissions_send_to_external_referee"

  post '/submission_tools/update_status_of_submission/:submission_id/:status', to: "submissions#update_status_of_submission", as: "update_status_of_submission"
  post '/submission_tools/propose_submission/:submission_id/', to: "submissions#propose_submission", as: "propose_submission"
  post '/submission_tools/withdraw_proposal_of_submission/:submission_id/', to: "submissions#withdraw_proposal_of_submission", as: "withdraw_proposal_of_submission"
  post '/submission_tools/upload_file_to_submission/:submission_id/', to: "submissions#upload_file_to_submission", as: "upload_file_to_submission"
  post '/submission_tools/add_comment_to_submission/:id/', to: "submissions#add_comment_to_submission", as: "add_comment_to_submission"
  get '/submission_tools/send_notifications/', to: "submissions#send_notifications", as: "send_notifications"
  post '/submission_tools/add_me_to_blocked_users/:submission_id/', to: "submissions#add_me_to_blocked_users", as: "add_me_to_blocked_users_submission"

  post '/submission_tools/upload_csv', to: "submissions#upload_csv", as: "submissions_upload_csv"

  get '/submission_tools/download_csv/', to: "submissions#download_csv", as: "submissions_download_csv"

  post '/submission_tools/create_or_update_submission', to: "submissions#create_or_update_submission", as: "create_or_update_submission"

  post '/submission_tools/make_submission_dead/:submission_id/', to: "submissions#make_submission_dead", as: "make_submission_dead"
  post '/submission_tools/make_submission_alive/:submission_id/', to: "submissions#make_submission_alive", as: "make_submission_alive"

  post '/submission_tools/resurrect_submission/:submission_id/', to: "submissions#resurrect_submission", as: "resurrect_submission"


  post '/submission_tools/reject_submission/:submission_id/', to: "submissions#reject_submission", as: "reject_submission"
  post '/submission_tools/accept_submission/:submission_id/', to: "submissions#accept_submission", as: "accept_submission"


  get '/codes/editor/:id', to: "codes#editor", as: "codes_editor"
  post '/codes/editor/:id', to: "codes#editor", as: "codes_editor_post"
  post '/codes-tool/update_editor/:id', to: "codes#update_editor", as: "codes_update_editor"

  get '/codes-tools/my_codes', to: "codes#my_codes", as: "my_codes"
  post '/codes-tools/create_new_code_for_user', to:"codes#create_new_code_for_user", as: "create_new_code_for_user"

  get '/codes-tools/download/:id', to: "codes#download", as: "codes_download"

  get '/jsons-tools/json_view/:id', to: "jsons#json_view", as: "json_view"
  get '/jsons-tools/editor/:id', to: "jsons#json_editor", as: "json_editor"
  post '/jsons-tools/editor_update/:id', to: "jsons#json_editor_update", as: "json_editor_update"

  post '/jsons-tools/json_view_editor_update/:id', to: "jsons#json_view_editor_update", as: "json_view_editor_update"

  get '/report-tools/new_for_reviewer/:submission_id', to: "reports#new_for_reviewer", as: "new_report_for_reviewer"

  post '/external_referee_submission_tools/fast_update/:id', to: "external_referee_submissions#fast_update", as: "external_referee_submissions_fast_update"

  post '/external_referee_tools/fast_create/:submission_id', to: "external_referees#fast_create", as: "external_referee_fast_create"

  get '/principles', to: "pages#principles", as: "principles"

  get '/:id', to: "pages#show"
end
