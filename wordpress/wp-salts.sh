#!/bin/bash
set -e

SALTFILE=${1-"$WORDPRESS_SALTS_PATH"}
OWNERGROUP=${2-root:www-data}
PERMS=${3-664}

echo "<?php" >  "$SALTFILE"
curl https://api.wordpress.org/secret-key/1.1/salt/ >> "$SALTFILE"
echo "?>" >>  "$SALTFILE"

chown $OWNERGROUP "$SALTFILE"
chmod $PERMS "$SALTFILE"
