FROM ruby:3.2-alpine

WORKDIR /app

RUN apk add --update \
    build-base \
    postgresql-client \
    postgresql-dev \
    git \
    tzdata \
    yarn \
    && rm -rf /var/cache/apk/*

COPY Gemfile* ./
ENV BUNDLE_PATH /gems
RUN bundle config set force_ruby_platform true
RUN bundle install

COPY package.json *yarn* ./
RUN yarn install

COPY . .

CMD ["bin/rails", "server", "--binding", "0.0.0.0"]

EXPOSE 3000