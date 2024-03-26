FROM ruby:2.6.3
RUN apt-get update && apt-get install -y nodejs

RUN apt-get install -y wget ca-certificates lsb-release
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN echo lsb_release -cs
RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
RUN apt-get update
RUN apt install -y postgresql-12 postgresql-client-12


WORKDIR /app
COPY Gemfile* .
RUN gem install bundler:2.2.26
RUN bundle install


COPY . .
ENTRYPOINT [ "sh", "get_database_and_migrate_and_start.sh" ]
#CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]



