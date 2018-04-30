FROM library/mediawiki

# msmtp and the basics for poking around as i get them set up
RUN apt-get update && apt-get install -y \
        less \
        msmtp \
        vim && \
    apt-get clean && \
    rm -r /var/lib/apt/lists/*;

RUN { \
		echo "sendmail_path=$(which msmtp) -ti "; \
	} >> /usr/local/etc/php/php.ini


# install uploadwizard, for multifile uploads
# https://www.mediawiki.org/wiki/Extension:UploadWizard
# this is the standard multi upload tool used by mw commons
RUN curl -L "https://extdist.wmflabs.org/dist/extensions/UploadWizard-REL1_30-916ed2d.tar.gz" | tar xvfz - -C /var/www/html/extensions

# DEFAULT ENV VARS
ENV MEDIAWIKI_TABLE_PREFIX ''
ENV MEDIAWIKI_ENABLE_UPLOADS 0

# COPY DYNAMIC SETTINGS
COPY LocalSettings.php /var/www/html/LocalSettings.php

COPY ./msmtp-sendgrid-entrypoint.sh /usr/local/bin
ENTRYPOINT ["msmtp-sendgrid-entrypoint.sh"]
CMD ["apache2-foreground"]
