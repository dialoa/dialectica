#!/bin/bash

echo "Deploying to server..."
ssh sandro@fishpond << EOF
export RAILS_ENV=production
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/it
cd dialectica
git stash
git pull origin master
rails assets:clobber
rails assets:precompile
git add public
git commit -m "precompile"
git push origin master
bundle config set --local without 'development test'
bundle install
rails db:migrate
EOF

echo "Restarting Nginx..."
ssh root@fishpond << EOF
cd /home/sandro/dialectica/
sudo service nginx restart
EOF

ssh sandro@fishpond << EOF
yarn install --check-files
EOF
