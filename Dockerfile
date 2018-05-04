FROM parthmodi/rails_base:latest

RUN apt-get update && \
    apt-get install -y libpq-dev imagemagick && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

ENV RAILS_LOG_TO_STDOUT true


# Workdir
ENV RAILS_ROOT /home/app
RUN mkdir -p $RAILS_ROOT
WORKDIR /home/app

# Install gems
COPY Gemfile* $RAILS_ROOT/
RUN bundle install

# # Create user and group
RUN groupadd --gid 9999 app && \
    useradd --uid 9999 --gid app app && \
    chown -R app:app $RAILS_ROOT

# Add the Rails app
COPY . $RAILS_ROOT/

ENV APPNAME deals_app

EXPOSE 3000

ENTRYPOINT [ "docker/entrypoint.sh" ]
CMD [ "bundle", "exec", "rails", "server", "-p", "3000" ]
# CMD [ "bundle", "exec", "rails", "server", "-p", "3000", "-b", "0.0.0.0" ]