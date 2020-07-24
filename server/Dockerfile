FROM ruby:2.7.1-alpine
RUN apk add --no-cache \
    build-base \
    ruby-dev \
    tzdata \
    postgresql-dev \
    postgresql-client \
    sqlite-dev \
    git
RUN gem install bundler && \
    gem install foreman
WORKDIR /app
COPY Gemfile /app
COPY Gemfile.lock /app
RUN bundle install
COPY . /app
EXPOSE 80

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
