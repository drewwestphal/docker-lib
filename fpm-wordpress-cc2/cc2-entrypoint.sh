#!/bin/bash
set -euo pipefail

ln -fs /usr/local/src/CC2/wp-plugin /var/www/html/plugins/CC2;

# link up as many plugins are we are given in our config
# it seems like the way compose imports these variables loses lines
# so i just go through the pairs here
# this is a hack to avoid restructuring the client plugin folders

name_idx=0
path_idx=1
array=($CC2_PLUGIN_NAME_TO_PATH_LINES_SPACE_DELIMITED)
while [ $path_idx -lt ${#array[@]} ]; do
    path="${array[$path_idx]}"
    name="${array[$name_idx]}"
    echo "symlinking plugin [$name] to [$path]"
    ln -fs "$path" "/var/www/html/plugins/$name"
    ((name_idx+=2))
    ((path_idx+=2))
done

wp --require=$TGMPA_COMMAND_FILEPATH tgmpa-plugin install --all || true

exec wordpress-entrypoint.sh "$@"
