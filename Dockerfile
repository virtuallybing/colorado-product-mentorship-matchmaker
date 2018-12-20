FROM ruby:2.5.1

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /matchmaker
WORKDIR /matchmaker

COPY Gemfile /matchmaker/Gemfile
COPY Gemfile.lock /matchmaker/Gemfile.lock
RUN bundle install

COPY . /matchmaker
COPY ./config/database.docker.yml /matchmaker/config/database.yml
