FROM drewwestphal/fpm

# the script i'm using here depends on tini
ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /sbin/tini
RUN chmod +x /sbin/tini


RUN curl https://raw.githubusercontent.com/composer/docker/b414f0a74b10d9c4359530a94dcd450c0a858d77/1.10/docker-entrypoint.sh\
 > /usr/local/bin/composer-entrypoint.sh && chmod +x /usr/local/bin/composer-entrypoint.sh

WORKDIR /tmp
RUN rm -rf /tmp/*



ENTRYPOINT ["composer-entrypoint.sh"]

CMD ["composer"]
