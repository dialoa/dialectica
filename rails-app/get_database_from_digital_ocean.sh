#!/bin/bash
#  pg_dump dialectica_production > latest.sql
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus

ssh sandro@159.65.120.231 << EOF
  cd dialectica
  pg_dump --format=custom dialectica_production > latest.dump
EOF

scp sandro@159.65.120.231:/home/sandro/dialectica/latest.dump latest.dump

rails db:drop DISABLE_DATABASE_ENVIRONMENT_CHECK=1
rails db:create
rails db:migrate

#psql dialectica_development < latest.sql
pg_restore --verbose --clean --no-acl --no-owner -d dialectica_development latest.dump

mkdir -p ~/backups/dialectica
cp latest.dump ~/backups/dialectica/"$(date +"%y-%m-%d")".dump
/usr/bin/notify-send "dialectica - backup complete"
