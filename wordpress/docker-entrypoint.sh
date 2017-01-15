#!/bin/bash
set -euo pipefail

# run this on start to switch up cookie perms
wp-salts.sh;

exec "$@"
