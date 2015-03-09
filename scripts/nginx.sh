#!/usr/bin/env bash

set -e
echo 'Running nginx script...'

sudo -s -u vagrant

add-apt-repository ppa:nginx/stable
apt-get -y update 
apt-get -y install nginx

service nginx stop

echo "manual" > /etc/init/nginx.override
