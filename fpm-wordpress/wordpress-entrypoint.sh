#!/bin/bash
set -euo pipefail

# run this on start to switch up cookie perms
wp-salts.sh;
# in case any volumes have been mounted
wp-perms.sh;

exec fpm-entrypoint.sh "$@"
