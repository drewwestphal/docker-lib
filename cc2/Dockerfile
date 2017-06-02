FROM drewwestphal/wordpress

RUN mkdir -p /usr/local/src/CC2/wp-plugin && \
    mkdir -p /usr/local/src/CC2-client/plugin;


COPY cc2-entrypoint.sh /usr/local/bin
ENTRYPOINT ["cc2-entrypoint.sh"]
CMD ["php-fpm"]
