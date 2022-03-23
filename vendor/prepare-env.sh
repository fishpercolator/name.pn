#!/bin/bash

uid=$1

# Install nodejs, yarn, pg_dump, chromium
set -e
echo "deb http://ftp.debian.org/debian buster main" > /etc/apt/sources.list.d/buster.list
curl -sL https://deb.nodesource.com/setup_12.x | bash -
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -\
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
apt-get update -y && apt-get install -y chromium iproute2 nodejs postgresql-client-11 vim yarn && apt-get clean

# Create a user
adduser rails --uid $uid --disabled-password --gecos ""
