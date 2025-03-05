# base
FROM ruby:3.4.2 AS base

RUN apt-get update -qq && apt-get install -y \
    postgresql-client \
    chromium \
    libpq-dev \
    libnss3 \
    libgconf-2-4 \
    libxss1 \
    fonts-liberation \
    libappindicator3-1 \
    xdg-utils

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
