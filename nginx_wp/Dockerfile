FROM dockerlib_nginx

#COPY ./fastcgi.conf /etc/nginx/fastcgi.conf
COPY ./wordpress-vhost.template.conf /etc/nginx/conf.d/wordpress-vhost.template
COPY ./wordpress.conf /etc/nginx/global/wordpress.conf