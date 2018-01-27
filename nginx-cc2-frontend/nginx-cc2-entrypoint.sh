#!/bin/bash
set -euo pipefail

htpasswd -nb "$CC2_ADMIN_HTTP_AUTH_USER" "$CC2_ADMIN_HTTP_AUTH_PASS" > "$RESTRICTED_AREA_HTPASSWD_PATH"

unset CC2_ADMIN_HTTP_AUTH_USER CC2_ADMIN_HTTP_AUTH_PASS;

# down the rabbit hole
exec nginx-envtmpl-entrypoint.sh "$@"
