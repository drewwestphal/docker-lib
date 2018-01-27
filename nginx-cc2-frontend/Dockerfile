FROM drewwestphal/nginx-wordpress-frontend

ENV RESTRICTED_AREA_HTPASSWD_PATH /etc/nginx/.restricted_area_htpasswd

COPY ./restricted-area-htpasswd.conf.ngxtpl /etc/nginx/include/wordpress.conf.d/restricted-area-htpasswd.conf.ngxtpl

COPY ./nginx-cc2-entrypoint.sh /usr/local/bin/nginx-cc2-entrypoint.sh
ENTRYPOINT ["nginx-cc2-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
