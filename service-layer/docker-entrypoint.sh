#!/bin/sh
set -e
STAGE=dev
$(aws ssm get-parameters-by-path --with-decryption --path /eli/"${STAGE}"/app \
  | jq -r '.Parameters| .[] | "export " + .Name + "=\"" + .Value + "\""  '  \
  | sed -e "s~/eli/"${STAGE}"/app/~~" | tr -d '"' )

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi
exec bundle exec "$@"
