#!/bin/sh
set -e

# replace cluster definition
sed -i "s~CLUSTER~$BRANCH~;s~BRANCH~$BRANCH~;s~AWS_DEFAULT_REGION~$AWS_DEFAULT_REGION~;s~DOMAIN~$DOMAIN~;s~AWS_SECRET_ACCESS_KEY~$AWS_SECRET_ACCESS_KEY~;s~AWS_ACCESS_KEY_ID~$AWS_ACCESS_KEY_ID~" /etc/traefik/traefik.toml

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
    set -- traefik "$@"
fi

# if our command is a valid Traefik subcommand, let's invoke it through Traefik instead
# (this allows for "docker run traefik version", etc)
if traefik "$1" --help 2>&1 >/dev/null | grep "help requested" > /dev/null 2>&1; then
    set -- traefik "$@"
fi

exec "$@"
