#!/bin/bash
set -e

SALTFILE=${1-"$WORDPRESS_SALTS_PATH"}

echo "<?php" >  "$SALTFILE"
curl https://api.wordpress.org/secret-key/1.1/salt/ >> "$SALTFILE"
echo "?>" >>  "$SALTFILE"

wp-perms.sh "$SALTFILE"
