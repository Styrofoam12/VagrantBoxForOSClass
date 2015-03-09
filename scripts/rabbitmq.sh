#!/usr/bin/env bash

set -e
echo 'Running rabbitmq script...'

sudo -s -u vagrant

if ! grep -q "deb http://www.rabbitmq.com/debian/ testing main" /etc/apt/sources.list; then
  echo "deb http://www.rabbitmq.com/debian/ testing main" >> /etc/apt/sources.list
fi

wget http://www.rabbitmq.com/rabbitmq-signing-key-public.asc
apt-key add rabbitmq-signing-key-public.asc
rm rabbitmq-signing-key-public.asc
apt-get -y update
apt-get -y install rabbitmq-server

rabbitmq-plugins enable rabbitmq_management

service rabbitmq-server stop

cp /vagrant/templates/rabbitmq.config /etc/rabbitmq/

chown rabbitmq /etc/rabbitmq/rabbitmq.config 
chmod 0400 /etc/rabbitmq/rabbitmq.config 

echo "LKJSHFDUIAHWAELJKDHSFKJDHAHKJLGFSDSKJ" > /etc/rabbitmq/.erlang.cookie
chmod 0400 /etc/rabbitmq/.erlang.cookie

echo "manual" > /etc/init/rabbitmq-server.override
