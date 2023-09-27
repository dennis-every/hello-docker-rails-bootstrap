FROM ruby:3.2-alpine

RUN apk add --update \
    build-base \
    postgresql-client \
    postgresql-dev \
    git \
    tzdata \
    && rm -rf /var/cache/apk/*

WORKDIR /app
COPY . /app/

ENV BUNDLE_PATH /gems
RUN bundle config set force_ruby_platform true
RUN bundle install

CMD ["bin/dev"]

EXPOSE 3000