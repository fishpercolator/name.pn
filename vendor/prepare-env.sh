#!/bin/bash

uid=$1

# Install nodejs, yarn, pg_dump, chromium
set -e
apt-get update -y && apt-get install -y chromium iproute2 libvips nodejs postgresql-client vim yarnpkg && apt-get clean
ln -s /usr/bin/yarnpkg /usr/bin/yarn

# Create a user
adduser rails --uid $uid --disabled-password --gecos ""
