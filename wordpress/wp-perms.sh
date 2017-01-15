#!/bin/bash

TARGET="${1-$WEB_ROOT}"
OWNERGROUP=${2-root:www-data}
FILE_PERMS=${3-664}
DIR_PERMS=${3-775}

echo "applying wp-perms to [$TARGET]"

if [[ -f "$TARGET" ]]; then
    chown "$OWNERGROUP" "$TARGET";
    chmod "$FILE_PERMS" "$TARGET";
else
    find "${WEB_ROOT}" -not -type l -exec chown "$OWNERGROUP" "{}" +
    find "${WEB_ROOT}" -not -type l -type f -exec chmod "$FILE_PERMS" "{}" +
    find "${WEB_ROOT}" -not -type l -type d -exec chmod "$DIR_PERMS" "{}" +
fi

# from https://www.smashingmagazine.com/2014/05/proper-wordpress-filesystem-permissions-ownerships/
# we have these files in both places
sudo chmod 660 "${WORDPRESS_ABS_PATH}/wp-config.php" &> /dev/null || true
sudo chmod 660 "${WORDPRESS_ABS_PATH}/index.php" &> /dev/null || true
sudo chmod 660 "${WEB_ROOT}/wp-config.php" &> /dev/null || true
sudo chmod 660 "${WEB_ROOT}/index.php" &> /dev/null || true
