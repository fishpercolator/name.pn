# syntax = docker/dockerfile:1

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version and Gemfile
ARG RUBY_VERSION=3.1.3
FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim as base

# Rails app lives here
WORKDIR /rails

# Set development environment
ENV BUNDLE_PATH="/usr/local/bundle"

# Install apt dependencies
ARG NODE_MAJOR=18
COPY vendor/install-dependencies.sh /tmp
RUN /tmp/install-dependencies.sh $NODE_MAJOR

# Install application gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Install application JS
COPY package.json yarn.lock ./
RUN yarn

# Copy application code
COPY . .

# Build assets in dev mode
RUN yarn build
RUN yarn build:css

ENV DEFAULT_DOMAIN localhost

# Entrypoint prepares the database.
ENTRYPOINT ["/rails/bin/docker-entrypoint"]
LABEL "com.datadoghq.ad.logs"='[{"source": "ruby", "service": "name-pn"}]'

# Start the server by default, this can be overwritten at runtime
EXPOSE 3000
CMD ["./bin/rails", "server"]
