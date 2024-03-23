FROM ruby:2.6.3
RUN apt-get update && apt-get install -y nodejs

WORKDIR /app
COPY Gemfile* .
RUN gem install bundler:2.2.26
RUN bundle install
COPY . .
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]


