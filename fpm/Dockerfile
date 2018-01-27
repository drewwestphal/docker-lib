FROM php:7.2.1-fpm

# from https://github.com/docker-library/wordpress/blob/master/php7.1/fpm/Dockerfile
# installation of base wordpress necessities
# install the PHP extensions we need
RUN set -ex; \
	\
	apt-get update; \
	apt-get install -y \
		libicu-dev \
		libjpeg-dev \
		libmcrypt-dev \
		libpng-dev \
	; \
	rm -rf /var/lib/apt/lists/*; \
	\
	docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr; \
	docker-php-ext-configure intl; \
	docker-php-ext-install gd mysqli opcache intl pdo pdo_mysql
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
        vim && \
    apt-get clean && \
    rm -r /var/lib/apt/lists/*;

# configure sendmail
RUN { \
		echo "php_admin_value[sendmail_path] = $(which msmtp) -ti "; \
	} >> /usr/local/etc/php-fpm.d/www.conf

# install composer
# from https://getcomposer.org/doc/faqs/how-to-install-composer-programmatically.md
ADD install-composer.sh /tmp
RUN /tmp/install-composer.sh && rm /tmp/install-composer.sh

# set container to nyc time...
RUN echo "America/New_York" > /etc/timezone

# https://github.com/docker/docker/issues/8631
RUN echo "export TERM=xterm" >> /etc/bash.bashrc

# configure entrypoint
COPY fpm-entrypoint.sh /usr/local/bin
ENTRYPOINT ["fpm-entrypoint.sh"]
CMD ["php-fpm"]
