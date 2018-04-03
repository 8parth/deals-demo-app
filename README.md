# Usage Instructions

- Clone the repo.
- Execute `bundle install` to install dependencies and gems.
- Run `bundle exec rails db:create` to setup database.
- Run `bundle exec rails db:migrate` to run migrations.
- Run `bundle exec puma -p ${PORT:-3000} -e ${RACK_ENV:-development}`.
- Alternatively, after cloning the repo you can run `bin/setup` to install dependencies.

# Development Instructions

After checking out the repo, run bin/setup to install dependencies. Then, run rake spec to run the tests. You can also run bin/console for an interactive prompt that will allow you to experiment.

- Rails Version 5.1.5
- Ruby Version 2.4.1
- PostgreSQL 9.5.10
