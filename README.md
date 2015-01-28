# Hubot Test Box

Ubuntu Vagrant box provisioned with Hubot and the Slack adapter.

## Auth

To authorize your Hubot box to connect with your Slack account, place a file
named `hubot_slack_token` in the root directory of this repository. *Note:* The
file is gitignored.

```sh
echo "slack-token-here" > hubot_slack_token
```

