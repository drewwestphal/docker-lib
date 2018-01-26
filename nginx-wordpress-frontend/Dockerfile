FROM drewwestphal/nginx-envtmpl

#COPY ./fastcgi.conf /etc/nginx/fastcgi.conf
COPY ./wordpress-vhost.conf.ngxtpl /etc/nginx/conf.d/wordpress-vhost.conf.ngxtpl
COPY ./wordpress.conf /etc/nginx/include/wordpress.conf

ENV WORDPRESS_FPM_UPSTREAM fpm:9000