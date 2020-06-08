FROM ruby:2.7.1-slim

RUN apt update && apt install -qq -y --no-install-recommends build-essential libpq-dev

ENV INSTALL_PATH /translatechatbot

RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

#CMD rackup config.ru -o 0.0.0.0