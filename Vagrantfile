# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  # Set env specific args to pass to provision.sh.
  def provisioning(config, shell_arguments)
    config.vm.provision "shell", path: "provision.sh", args: shell_arguments
  end

  # DEV
  config.vm.define "dev" do |dev|
    provisioning(dev, ["dev", "vagrant"])
    dev.vm.box = "ubuntu/trusty64"
    dev.vm.hostname = "hubot-dev"
  end

  # PROD
  config.vm.define "prod", autostart: false do |prod|
    provisioning(prod, ["prod", "ubuntu"])

    # Default vagrant-aws plugin box is "dummy".
    # vagrant box add dummy https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box
    prod.vm.box = "dummy"

    # AWS
    prod.vm.provider "aws" do |aws, override|
      # Auth
      aws.access_key_id = ENV['ACCESS_KEY_ID']
      aws.secret_access_key = ENV['SECRET_ACCESS_KEY']

      # Instance
      aws.tags = { "Name" => "Hubot-instance" }
      aws.iam_instance_profile_name = "HubotRole"
      aws.security_groups = [ "HubotSG" ]
      aws.keypair_name = "hubot"
      override.ssh.private_key_path = "~/.ssh/hubot.pem"
      override.ssh.username = "ubuntu"

      ### Choose AWS region and instance size, uncomment a group below.

      # # Ubuntu 14.04 64-bit (HVM) instance. Must be m3.medium or greater.
      # aws.region = "us-east-1"
      # aws.instance_type = "m3.medium"
      # aws.region_config "us-east-1", :ami => "ami-ce5be9a6"
      # aws.region_config "us-west-1", :ami => "ami-5bbab11e"
      # aws.region_config "us-west-2", :ami => "ami-a385c893"

      # Ubuntu 14.04 64-bit instance. Use for t1.micro low resource needs.
      aws.region = "us-east-1"
      aws.instance_type = "t1.micro"
      aws.region_config "us-east-1", :ami => "ami-c65be9ae"
      aws.region_config "us-west-1", :ami => "ami-7bbab13e"
      aws.region_config "us-west-2", :ami => "ami-7785c847"
    end
  end

  # There are double excludes settings for aws plugin support
  excludes = [".git/", "myhubot/node_modules"]
  config.vm.synced_folder ".", "/vagrant",
    type: "rsync", rsync__exclude: excludes, rsync_excludes: excludes
end
