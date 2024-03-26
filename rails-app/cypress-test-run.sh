RAILS_ENV=test rails db:drop
RAILS_ENV=test rails db:create
RAILS_ENV=test rails db:migrate
RAILS_ENV=test rails db:seed
rails s -e test
#DOES NOT WORK
