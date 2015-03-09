#!/usr/bin/env bash

set -e

echo 'Installing JavaScript development tools...'

add-apt-repository -y ppa:chris-lea/node.js

apt-get -y update
apt-get -y install nodejs

npm install -g grunt grunt-cli
npm install -g bower
