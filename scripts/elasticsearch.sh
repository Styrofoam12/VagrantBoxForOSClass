#!/usr/bin/env bash

set -e
echo 'Running elasticsearch script...'

es_path="deb http://packages.elasticsearch.org/elasticsearch/1.0/debian stable main"
source_path="/etc/apt/sources.list" 
es_data_path="/usr/share/elasticsearch/data"

if ! grep -q "elasticsearch" $source_path; then
  wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add -
  echo $es_path >> $source_path
fi

apt-get -y update
apt-get -y install elasticsearch 

service elasticsearch stop

mkdir -p  $es_data_path
chmod 777 $es_data_path

echo "manual" > /etc/init/elasticsearch.override
echo 'export PATH=$PATH:/usr/share/elasticsearch/bin' > /etc/profile.d/elasticsearchpath.sh
