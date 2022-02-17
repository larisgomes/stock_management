FROM ruby:2.6.5

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y postgresql-client --no-install-recommends && rm -rf /var/lib/apt/lists/*

#COPY Gemfile /usr/src/app/
COPY . /usr/src/app

RUN gem install bundler
RUN bundle install

EXPOSE 3000

CMD rake db:setup && rails s -b 0.0.0.0
