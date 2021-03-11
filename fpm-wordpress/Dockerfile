FROM drewwestphal/fpm

## IMPORTANT CONFIGURABLES
ENV CONTAINER_WP_VERSION 5.7
ENV CONTAINER_WP_LOCALE en_US
# ao 2/18/20 2.4.1 is busted
ENV WP_CLI_VERSION 2.4.0
ENV WP_CLI_CONF_DIR /var/wp-cli
ENV WP_CLI_USER www-data

ENV WEB_ROOT /var/www/html
ENV WORDPRESS_ABS_PATH "$WEB_ROOT/wp"


# install wp-cli
WORKDIR /usr/local/bin

RUN curl -L "https://github.com/wp-cli/wp-cli/releases/download/v$WP_CLI_VERSION/wp-cli-$WP_CLI_VERSION.phar" \
    -o ./wp-cli.phar;

# set up a directory for packages belonging to wp-cli extensions
ENV WP_CLI_PACKAGES_DIR $WP_CLI_CONF_DIR/packages
ENV WP_CLI_CACHE_DIR $WP_CLI_CONF_DIR/packages
RUN mkdir -p "$WP_CLI_PACKAGES_DIR" && \
    chown $WP_CLI_USER "$WP_CLI_PACKAGES_DIR" && \
    chown $WP_CLI_USER "$WP_CLI_CACHE_DIR" && \
    chmod 700 "$WP_CLI_PACKAGES_DIR" "$WP_CLI_CACHE_DIR"

# build the command for wp
# include environment variables (wordpress config needs them)
RUN echo "#!/bin/bash" > wp && \
    echo "exec sudo --preserve-env -u $WP_CLI_USER \
    php /usr/local/bin/wp-cli.phar \
     --path=$WORDPRESS_ABS_PATH \
     \"\$@\"" >> wp && \
    chmod 700 wp;

#RUN wp package install itspriddle/wp-cli-tgmpa-plugin;

# helper tools
#for dynamic salts
COPY wp-salts.sh wp-salts.sh
#for resetting, fixing all perms
COPY wp-perms.sh wp-perms.sh

WORKDIR "$WEB_ROOT"

# install wordpress
ENV WORDPRESS_SALTS_PATH "$WORDPRESS_ABS_PATH/salts.php"
RUN mkdir -p "$WORDPRESS_ABS_PATH" && wp-perms.sh "$WORDPRESS_ABS_PATH";
RUN wp core download \
    --path="$WORDPRESS_ABS_PATH" \
    --version="$CONTAINER_WP_VERSION"  \
    --locale="$CONTAINER_WP_LOCALE" \
    ;


# create a subdirectory install
COPY wp-config.php "$WORDPRESS_ABS_PATH/wp-config.php"
COPY index.php "$WORDPRESS_ABS_PATH/index.php"

# we need these at the web root as well...
# move themes as a convenience to new installs...
RUN cp "$WORDPRESS_ABS_PATH/wp-config.php" "$WORDPRESS_ABS_PATH/index.php" ./ && \
    mv "$WORDPRESS_ABS_PATH/wp-content/themes/" ./ && \
    mv "$WORDPRESS_ABS_PATH/wp-content/plugins/" ./ && \
    rm -r "$WORDPRESS_ABS_PATH/wp-content" && \
    mkdir -p ./uploads && \
    wp-salts.sh && \
    wp-perms.sh


# configure entrypoint
COPY wordpress-entrypoint.sh /usr/local/bin
ENTRYPOINT ["wordpress-entrypoint.sh"]