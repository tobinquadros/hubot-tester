# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.hostname = "hubot-dev"
  config.vm.provision "shell", path: "provision.sh"

  # To run an rsync watcher: vagrant rsync-auto &
  config.vm.synced_folder ".", "/vagrant",
    type: "rsync", rsync__exclude: [".git/", "myhubot/node_modules"]
end
