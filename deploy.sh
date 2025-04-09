#!/bin/bash
rails assets:clobber
RAILS_ENV=production rails assets:precompile
git add .
git commit -m "precompile"
git push origin master


ssh sandro@fishpond << EOF
  cd dialectica
  git stash
  git pull origin master
  bundle config set --local without 'development test'
  bundle install
  RAILS_ENV=production rails db:migrate
EOF

ssh root@fishpond << EOF
  cd /home/sandro/dialectica/
  sudo service nginx restart
EOF

yarn install --check-files
