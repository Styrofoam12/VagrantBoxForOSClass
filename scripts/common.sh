#!/usr/bin/env bash

set -e
echo 'Running Ubuntu common script...'

as_vagrant='sudo -u vagrant -H bash -l -c'
home='/home/vagrant'
sudo -u vagrant touch $home/.bash_profile

apt-get -y update
apt-get -y upgrade
apt-get -y purge --auto-remove puppet
apt-get -y purge --auto-remove chef 

apt-get -y install \
  build-essential \
  libncurses5-dev \
  tree \
  ack-grep \
  curl \
  git-core \
  git \
  unzip \
  htop \
  ntp \
  vim \
  bash-completion \
  bochs \
  bcc 
  
sudo apt-get -y install --no-install-recommends ubuntu-desktop

# add /vagrant/bin to the PATH
if ! grep -q "/vagrant/bin" $home/.bash_profile; then
  echo "export PATH=\$PATH:/vagrant/bin" >> $home/.bash_profile
fi
