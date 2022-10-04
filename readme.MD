# GCP Slack Dad Jokes

This repo contains a Google Cloud function which gets a joke from the [dad joke api](https://icanhazdadjoke.com/api) and posts it into the `dad-joke-channel` on slack.

The infrastructure is deployed with terraform into GCP and the joke is acquired by a small amount of python code.