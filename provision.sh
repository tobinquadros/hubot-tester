#!/usr/bin/env bash

# Install system dependencies.
curl -sL https://deb.nodesource.com/setup | sudo bash -
sudo apt-get install -y nodejs git-core build-essential
sudo apt-get -y upgrade

# Install hubot npm dependencies.
npm install -g hubot
npm install -g coffee-script
npm install -g yo
npm install -g generator-hubot

# Scaffold a hubot project
HUBOT_PROJ_NAME=myhubot
if [ ! -d /vagrant/$HUBOT_PROJ_NAME ]; then
  mkdir -p /vagrant/$HUBOT_PROJ_NAME
  cd /vagrant/$HUBOT_PROJ_NAME
  yo hubot \
    --owner="tobinquadros@gmail.com" \
    --name="$HUBOT_PROJ_NAME" \
    --description="Description goes here." \
    --adapter="slack" \
    --defaults
  npm install hubot-slack --save
fi

# Add upstart configuration.
cp /vagrant/upstart/myhubot.conf /etc/init/myhubot.conf

# Install any new packages.
sudo -u vagrant -i sh -c "cd /vagrant/myhubot; npm install"

# Ensure hubot is running.
sudo service myhubot restart

