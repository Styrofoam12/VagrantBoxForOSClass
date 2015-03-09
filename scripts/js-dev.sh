#!/usr/bin/env bash

set -e
echo 'Running js development script...'

sudo -s -u vagrant

add-apt-repository -y ppa:chris-lea/node.js

apt-get -y update
apt-get -y install nodejs

npm install -g bower
npm install -g grunt grunt-cli
