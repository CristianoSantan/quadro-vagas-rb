FROM ruby:3.4.2

RUN apt-get update -qq && apt-get install -y \
    nodejs \
    yarn \
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

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT [ "entrypoint.sh" ]

COPY . .

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]