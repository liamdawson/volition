FROM ruby:2.4-buster AS builder

RUN apt-get update -y \
  && apt-get install -y nodejs \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY Gemfile Gemfile.lock /app/

RUN bundle install \
  --deployment \
  --jobs=8 \
  --without=development \
  --without=test

COPY ./app/assets /app/assets

RUN bundle exec rails assets:precompile

COPY . /app/
