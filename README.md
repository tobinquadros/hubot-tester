# Hubot-Slack-Vagrant-EC2 Test Box

Ubuntu instance provisioned with Hubot and the Slack adapter. Works for
development environments on a local Vagrant VM, or to a production environment
on an Amazon EC2 instance.

###### For local development (Virtualbox or VMware Fusion)
```sh
cd hubot-tester
vagrant up dev --provider=virtualbox  # or just `vagrant up`
```

###### For production (AWS)
```sh
cd hubot-tester
vagrant up prod --provider=aws  # or just `vagrant up prod`
```

Lastly, login to Slack and direct message your hubot with 'ping', it will reply
'PONG' if the setup was successful.

## Auth

To authorize the Hubot instance to connect with your Slack account, you must
place a file named `hubot_slack_token` in the root directory of this
repository. To learn more see the [Slack Help
Center](https://slack.zendesk.com/hc/en-us).

```sh
cd hubot-tester
echo "slack-token-goes-here" > hubot_slack_token
```

**Note:** The `hubot_slack_token` file is gitignored, and should only be stored
temporarily.

To authorize Vagrant to access your AWS account you will need to export your
`ACCESS_KEY_ID` and `SECRET_ACCESS_KEY` as environment variables to be used by
the Vagrantfile. See the
[vagrant-aws](https://github.com/mitchellh/vagrant-aws) docs for more info.

```sh
export ACCESS_KEY_ID="access-key-goes-here"
export SECRET_ACCESS_KEY="secret-access-key-goes-here"
```

## Updating or reconfiguring Hubot

If you choose to start fresh or update the [myhubot](myhubot) directory, you
will need to reconfigure myhubot to ignore Heroku, and possibly make a few
other tweaks to the [myhubot/package.json](myhubot/package.json),
[myhubot/external-scripts.json](myhubot/external-scripts.json), and
[myhubot/bin/hubot](myhubot/bin/hubot). Please see the official
[Hubot](https://github.com/github/hubot/blob/master/docs/README.md) or
[adapter](https://github.com/github/hubot/blob/master/docs/adapters.md)
documentation.
