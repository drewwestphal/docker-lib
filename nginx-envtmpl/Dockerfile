FROM nginx:1.13

# set container to nyc time...
RUN echo "America/New_York" > /etc/timezone

# install envtpl (for building conf files) and other packages we like
# we'll need htpasswd too
RUN apt-get update && \
    apt-get install -y \
        python3-pip \
        sudo \
        apache2-utils \
        vim && \
    apt-get clean && \
    rm -r /var/lib/apt/lists/* && \
    pip3 install --no-cache-dir envtpl;

# default server config
COPY ./nginx.conf.ngxtpl /etc/nginx/nginx.conf.ngxtpl
COPY ./server-defaults.conf /etc/nginx/include/server-defaults.conf
COPY ./fastcgi.conf /etc/nginx/fastcgi.conf

RUN mkdir -p /etc/nginx/include/wordpress.conf.d

# ENVIRONMENT VARIABLES
ENV NGX_ROOT /var/www/html
ENV NGX_CLIENT_MAX_BODY_SIZE 10m
ENV NGX_GZIP_ON_OFF off
ENV NGX_ERROR_LOG_LEVEL warn
ENV NGX_SENDFILE on
# default is to include
ENV NGX_OMIT_GZIP_TYPES ''

COPY ./nginx-envtmpl-entrypoint.sh /usr/local/bin/nginx-envtmpl-entrypoint.sh
ENTRYPOINT ["nginx-envtmpl-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
