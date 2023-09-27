ARG RUBY_VERSION=3.2.2

FROM ruby:$RUBY_VERSION-alpine

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
VOLUME /bundle
RUN bundle config set --global path '/bundle'
ENV PATH="/bundle/ruby/$RUBY_VERSION/bin:${PATH}"
RUN bundle install

COPY package.json *yarn* ./
RUN yarn install

COPY . .

CMD ["bin/rails", "server", "--binding", "0.0.0.0"]

EXPOSE 3000