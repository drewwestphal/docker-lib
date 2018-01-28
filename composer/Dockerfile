FROM drewwestphal/fpm

# the script i'm using here depends on tini
ENV TINI_VERSION v0.16.1
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /sbin/tini
RUN chmod +x /sbin/tini


RUN curl https://raw.githubusercontent.com/composer/docker/master/1.6/docker-entrypoint.sh\
 > /usr/local/bin/composer-entrypoint.sh && chmod +x /usr/local/bin/composer-entrypoint.sh

WORKDIR /tmp
RUN rm -rf /tmp/*



ENTRYPOINT ["composer-entrypoint.sh"]

CMD ["composer"]
