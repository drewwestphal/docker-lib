FROM dockerlib_fpm

# end copy from docker-library

WORKDIR /usr/local/bin

RUN curl https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    -o ./wp-cli.phar;

# tools to run wp-cli as www-data (including sudo) and to do poking around (vim)
RUN apt-get update && apt-get install -y \
        less \
        sudo \
        vim;
RUN echo "#!/bin/bash" > wp && \
    echo "sudo -u www-data php /usr/local/bin/wp-cli.phar \"\$@\"" > wp && \
    chmod 700 wp;

# helper tools
#for dynamic salts
COPY wp-salts.sh wp-salts.sh
#for resetting, fixing all perms
COPY wp-perms.sh wp-perms.sh

ENV WEB_ROOT /var/www/html
WORKDIR /var/www/html

ENV WORDPRESS_ABS_PATH /var/www/html/wp
ENV WORDPRESS_SALTS_PATH "$WORDPRESS_ABS_PATH/salts.php"
RUN mkdir -p "$WORDPRESS_ABS_PATH" && wp-perms.sh "$WORDPRESS_ABS_PATH";
RUN wp core download --path="$WORDPRESS_ABS_PATH"
RUN wp-salts.sh
COPY wp-config.php "$WORDPRESS_ABS_PATH/wp-config.php"
COPY index.php "$WORDPRESS_ABS_PATH/index.php"
# we need these at the web root as well...
# move themes as a convenience to new installs...
RUN cp -r "$WORDPRESS_ABS_PATH/wp-config.php" "$WORDPRESS_ABS_PATH/index.php" && \
    mv "$WORDPRESS_ABS_PATH/wp-content/themes/" ./ && \
    mv "$WORDPRESS_ABS_PATH/wp-content/plugins/" ./ && \
    rm -r "$WORDPRESS_ABS_PATH/wp-content" && \
    mkdir -p ./uploads && \
    wp-perms.sh

VOLUME "/var/www/html"

COPY docker-entrypoint.sh /usr/local/bin
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["php-fpm"]
