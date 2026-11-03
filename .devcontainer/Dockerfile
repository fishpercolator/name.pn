# Make sure RUBY_VERSION matches the Ruby version in .ruby-version
ARG RUBY_VERSION=4.0.9
FROM ghcr.io/fishpercolator/devcontainer-rails:$RUBY_VERSION

# ImageMagick for name badges
USER root
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y imagemagick && \
    rm -rf /var/lib/apt/lists/*
USER vscode
