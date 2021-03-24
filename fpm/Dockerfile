FROM php:7.3.27-fpm

# from https://github.com/docker-library/wordpress/blob/master/php7.1/fpm/Dockerfile
# installation of base wordpress necessities
# install the PHP extensions we need
# installed memecached 2/18/20 per
RUN set -ex; \
	\
	apt-get update; \
	apt-get install -y \
		libicu-dev \
		libjpeg-dev \
		libmcrypt-dev \
		libpng-dev \
		libmemcached-dev \
		zlib1g-dev \
		libzip-dev \
	; \
	pecl install memcached-3.1.5; \
	rm -rf /var/lib/apt/lists/*; \
	\
	docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr; \
	docker-php-ext-configure intl; \
	docker-php-ext-install gd mysqli opcache intl pdo pdo_mysql zip; \
	docker-php-ext-enable memcached;
# TODO consider removing the *-dev deps and only keeping the necessary lib* packages


# the above installs an old version of libicu from ubuntu, which
# is not up to date for symfony use
# we are operating under the assumption this does not matter
# https://github.com/travis-ci/php-src-builder/blob/239e5287f3cabb95d6a25a3c2c5142138844b3cf/bin/install-icu


# set recommended PHP.ini settings
# see https://secure.php.net/manual/en/opcache.installation.php
RUN { \
		echo 'opcache.memory_consumption=128'; \
		echo 'opcache.interned_strings_buffer=8'; \
		echo 'opcache.max_accelerated_files=4000'; \
		echo 'opcache.revalidate_freq=2'; \
		echo 'opcache.fast_shutdown=1'; \
		echo 'opcache.enable_cli=1'; \
	} > /usr/local/etc/php/conf.d/opcache-recommended.ini

# tools to run wp-cli as www-data (including sudo) and to do poking around (vim)
# composer depends on git and zip
RUN apt-get update && apt-get install -y \
        less \
        sudo \
        git \
        zip \
        msmtp \
        wget \
        vim && \
    apt-get clean && \
    rm -r /var/lib/apt/lists/*;

# configure sendmail
RUN { \
		echo "php_admin_value[sendmail_path] = $(which msmtp) -ti "; \
	} >> /usr/local/etc/php-fpm.d/www.conf

ENV COMPOSER_VERSION 1.10.20

# install composer
# from https://getcomposer.org/doc/faqs/how-to-install-composer-programmatically.md
RUN wget https://raw.githubusercontent.com/composer/getcomposer.org/fe1f339fb41eb09a49bbdbda83bb8043d02e24fd/web/installer -O - -q | php -- --version $COMPOSER_VERSION
ENV COMPOSER_ALLOW_SUPERUSER 1
RUN chmod +x composer.phar && mv composer.phar /bin/composer

# set container to nyc time...
RUN echo "America/New_York" > /etc/timezone

# https://github.com/docker/docker/issues/8631
RUN echo "export TERM=xterm" >> /etc/bash.bashrc

# configure entrypoint
COPY fpm-entrypoint.sh /usr/local/bin
ENTRYPOINT ["fpm-entrypoint.sh"]
CMD ["php-fpm"]
