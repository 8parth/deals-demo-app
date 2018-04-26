#!/bin/bash
set -e

if [[ -a /tmp/puma.pid ]]; then
  rm /tmp/puma.pid
fi

echo "RAILS_ENV: $RAILS_ENV"
echo "running migrations..."
bundle exec rails db:create
bundle exec rails db:migrate

if [ $RAILS_ENV == "production" ]; then
  echo "precompiling assets..."
  bundle exec rails assets:precompile
fi

exec "$@"
