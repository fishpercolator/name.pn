#!/bin/bash

uid=$1

# Install nodejs, yarn, pg_dump, chromium
set -e
curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt-get update -y && apt-get install -y chromium iproute2 libvips nodejs postgresql-client vim && apt-get clean
npm install --global yarn

# Create a user
adduser rails --uid $uid --disabled-password --gecos ""
