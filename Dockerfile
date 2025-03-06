# base
FROM ruby:3.4.2 AS base

RUN apt-get update -qq && apt-get install -y \
    chromium \
    chromium-driver \
    build-essential \
    libpq-dev 

WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle install

# development
FROM base AS development
RUN apt-get install -y nodejs yarn

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT [ "entrypoint.sh" ]

COPY . .
EXPOSE 3000

# tests
FROM base AS test
COPY . .
