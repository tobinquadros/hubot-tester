#!/usr/bin/env bash

# Variables passed from Vagrantfile
environment=$1
run_as_user=$2

# Install system dependencies.
curl -sL https://deb.nodesource.com/setup | sudo bash -
sudo apt-get install -y nodejs git-core build-essential
sudo apt-get -y upgrade

# Install hubot npm dependencies.
npm install -g hubot
npm install -g coffee-script
npm install -g yo
npm install -g generator-hubot

# If necessary, scaffold a hubot project
hubot_proj_name=myhubot
if [ ! -d /vagrant/$hubot_proj_name ]; then
  mkdir -p /vagrant/$hubot_proj_name
  cd /vagrant/$hubot_proj_name
  yo hubot \
    --owner="user@example.com" \
    --name="$hubot_proj_name" \
    --description="Description goes here." \
    --adapter="slack" \
    --defaults
  npm install hubot-slack --save
fi

# Add upstart configuration, with override for dev and prod.
cp /vagrant/upstart/myhubot.conf /etc/init/myhubot.conf
cp /vagrant/upstart/myhubot.${environment}.override /etc/init/myhubot.override

# Install any new packages.
sudo -u ${run_as_user} -i sh -c "cd /vagrant/myhubot; npm install"

# Ensure hubot is running.
sudo service myhubot restart

