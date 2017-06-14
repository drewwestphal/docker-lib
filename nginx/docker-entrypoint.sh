#!/bin/bash
set -euo pipefail

# do envsubst automatically for all .template files
#inspired by https://hub.docker.com/_/nginx/
for TEMPLATE in $(find /etc/nginx/ -name '*.conf.ngxtpl'); do
    DEST="$(echo "$TEMPLATE" | sed "s/\.ngxtpl//g")"
    echo "Substituting for [$TEMPLATE] to make [$DEST]..."
    envtpl < "$TEMPLATE" > "$DEST"
done

exec "$@"
