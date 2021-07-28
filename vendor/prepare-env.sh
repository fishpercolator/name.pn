#!/bin/bash

uid=$1

# Install nodejs, yarn, pg_dump, chromium
set -e
echo "deb http://ftp.debian.org/debian buster main" > /etc/apt/sources.list.d/buster.list
curl -sL https://deb.nodesource.com/setup_12.x | bash -
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -\
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
apt-get update -y && apt-get install -y chromium nodejs postgresql-client-11 vim yarn && apt-get clean

# Create a user
adduser rails --uid $uid --disabled-password --gecos ""

# Install a custom version of foreman that supports JSON logging
cd /tmp
git clone https://github.com/stewartmckee/foreman.git --single-branch --branch output-formats
cd foreman
gem build foreman.gemspec
gem uninstall -a foreman
gem install foreman-*.gem
