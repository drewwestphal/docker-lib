#!/usr/bin/env sh
set -euo pipefail

# clean whatever was there
rm -f /etc/nginx/vhost.d/*

# copy whatever we got
cp -fv /tmp/customize-vhost/* /etc/nginx/vhost.d/

# no errors
exit 0