#!/bin/sh

set -e

NODE_MAJOR=$1

apt-get update -qq
apt-get upgrade -qqy

# Install deb dependencies
apt-get install --no-install-recommends -y build-essential chromium curl git gnupg iproute2 libpq-dev libvips pkg-config postgresql-client

# Install node
printf 'Package: nodejs\nPin: origin deb.nodesource.com\nPin-Priority: 1001' > /etc/apt/preferences.d/nodesource
mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list
apt-get update -qq
apt-get install --no-install-recommends -y nodejs

# Install yarn
npm install -g yarn@1

# Clean up
apt-get clean
rm -rf /var/lib/apt/lists/*
