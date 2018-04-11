FROM library/mediawiki

ENV MEDIAWIKI_TABLE_PREFIX ''

COPY LocalSettings.php /var/www/html/LocalSettings.php

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

COPY ./msmtp-sendgrid-entrypoint.sh /usr/local/bin
ENTRYPOINT ["msmtp-sendgrid-entrypoint.sh"]
CMD ["apache2-foreground"]
