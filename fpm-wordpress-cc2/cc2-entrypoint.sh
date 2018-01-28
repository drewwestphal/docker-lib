#!/bin/bash
set -euo pipefail

ln -fs /usr/local/src/CC2/wp-plugin /var/www/html/plugins/CC2;

wp --require=$TGMPA_COMMAND_FILEPATH tgmpa-plugin install --all || true

exec wordpress-entrypoint.sh "$@"
