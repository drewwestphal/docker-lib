FROM drewwestphal/nginx

#COPY ./fastcgi.conf /etc/nginx/fastcgi.conf
COPY ./wordpress-vhost.template.conf /etc/nginx/conf.d/wordpress-vhost.template
COPY ./wordpress.conf /etc/nginx/include/wordpress.conf

ENV NGX_FPM_UPSTREAM fpm:9000