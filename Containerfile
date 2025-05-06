# syntax = docker/dockerfile:1

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version and Gemfile
ARG RUBY_VERSION=3.4.3
FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim as base

# Rails app lives here
WORKDIR /rails

# Set development environment
ENV BUNDLE_PATH="/usr/local/bundle"

# Install packages needed to build gems and node modules
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential chromium curl git libpq-dev libvips libyaml-dev node-gyp pkg-config postgresql-common python-is-python3 rsync

# Install JavaScript dependencies
ARG NODE_VERSION=22.15.0
ARG YARN_VERSION=1.22.22
ENV PATH=/usr/local/node/bin:$PATH
RUN curl -sL https://github.com/nodenv/node-build/archive/master.tar.gz | tar xz -C /tmp/ && \
    /tmp/node-build-master/bin/node-build "${NODE_VERSION}" /usr/local/node && \
    npm install -g yarn@$YARN_VERSION && \
    rm -rf /tmp/node-build-master

# Install postgresql-client-16
RUN /usr/share/postgresql-common/pgdg/apt.postgresql.org.sh -v 16 && \
    apt-get install --no-install-recommends -y postgresql-client-16

# Install application gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Install node modules
COPY package.json yarn.lock ./
RUN yarn install

# Copy application code
COPY . .

# Build assets in dev mode
RUN yarn build
RUN yarn build:css

ENV DEFAULT_DOMAIN localhost

# Entrypoint prepares the database.
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Start the server by default, this can be overwritten at runtime
EXPOSE 3000
CMD ["./bin/rails", "server"]
