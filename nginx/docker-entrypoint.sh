#!/bin/bash

# do envsubst automatically for all .template files
#inspired by https://hub.docker.com/_/nginx/
for TEMPLATE in $(find /etc/nginx/ -name '*.template'); do
    DEST="$(echo "$TEMPLATE" | sed "s/.template/.conf/g")"
    echo "Substituting for [$TEMPLATE] to make [$DEST]..."
    cat "$TEMPLATE" | envsubst > "$DEST"
done

exec "$@"
