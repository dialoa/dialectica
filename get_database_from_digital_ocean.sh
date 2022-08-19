#!/bin/bash
ssh sandro@159.65.120.231 << EOF
  cd dialectica
  pg_dump dialectica_production > latest.sql
EOF

scp sandro@159.65.120.231:/home/sandro/dialectica/latest.sql latest.sql

rails db:drop DISABLE_DATABASE_ENVIRONMENT_CHECK=1
rails db:create
rails db:migrate

psql dialectica_development < latest.sql
