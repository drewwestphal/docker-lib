#!/bin/bash
set -euo pipefail

ln -nfs /usr/local/src/CC2/wp-plugin /var/www/html/plugins/CC2;

# link up as many plugins are we are given in our config
# it seems like the way compose imports these variables loses lines
# so i just go through the pairs here
# this is a hack to avoid restructuring the client plugin folders

dir_idx=0
name_idx=1
path_idx=2
array=($CC2_SYMLINK_WPDIR_NAME_TARGETPATH_SPACE_DELIMITED)
while [ $path_idx -lt ${#array[@]} ]; do
    dir="${array[$dir_idx]}"
    name="${array[$name_idx]}"
    target_path="${array[$path_idx]}"
    link_dir="/var/www/html/${dir}"
    link_name="${link_dir}/${name}"
    echo "link dir[$dir] name[$name] target_path[$target_path] link_name[$link_name]"
    # e.g. mu plugins doesn't necessarily exist
    mkdir -p "$link_dir"
    ln -nfs "$target_path" "$link_name"
    ((dir_idx+=3))
    ((name_idx+=3))
    ((path_idx+=3))
done

# turns out this sucks
#wp --require=$TGMPA_COMMAND_FILEPATH tgmpa-plugin install --all || true

exec wordpress-entrypoint.sh "$@"
