set -e
rm -f /app/tmp/pids/server.pid

bundle exec rails db:migrate

POSTGRES_URL="postgres://${DB_USERNAME}:${DB_PASSWORD}@db:5432/${DB_NAME}"

pg_restore --verbose --clean --no-acl --no-owner -d $POSTGRES_URL latest.dump

bundle exec rails server -b 0.0.0.0
#CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
