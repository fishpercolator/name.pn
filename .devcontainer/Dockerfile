# Make sure RUBY_VERSION matches the Ruby version in .ruby-version
ARG RUBY_VERSION=4.0.7
FROM ghcr.io/rails/devcontainer/images/ruby:$RUBY_VERSION

# Chromium for Cuprite-driven @javascript features
USER root
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y chromium && \
    rm -rf /var/lib/apt/lists/*
USER vscode

# Ensure binding is always 0.0.0.0
# Binds the server to all IP addresses of the container, so it can be accessed from outside the container.
ENV BINDING="0.0.0.0"
