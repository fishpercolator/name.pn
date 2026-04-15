# syntax = docker/dockerfile:1

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version and Gemfile
ARG RUBY_VERSION=4.0.1
FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim as base

# Rails app lives here
WORKDIR /rails

# Set development environment
ENV BUNDLE_PATH="/usr/local/bundle"

# Install packages needed to build gems and node modules
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential chromium curl git libpq-dev libvips libyaml-dev pkg-config postgresql-common rsync unzip

# Install JavaScript dependencies
ENV BUN_INSTALL=/usr/local/bun
ENV PATH=/usr/local/bun/bin:$PATH
ARG BUN_VERSION=1.3.8
RUN curl -fsSL https://bun.sh/install | bash -s -- "bun-v${BUN_VERSION}"

# Install postgresql-client-16
RUN /usr/share/postgresql-common/pgdg/apt.postgresql.org.sh -v 16 && \
    apt-get install --no-install-recommends -y postgresql-client-16

# Install application gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Install node modules
COPY package.json bun.lock ./
RUN bun install

# Copy application code
COPY . .

# Build assets in dev mode
RUN bun run build
RUN bun run build:css

ENV DEFAULT_DOMAIN localhost

# Entrypoint prepares the database.
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Start the server by default, this can be overwritten at runtime
EXPOSE 3000
CMD ["./bin/rails", "server"]
