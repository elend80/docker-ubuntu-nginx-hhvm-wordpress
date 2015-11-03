FROM elend80/docker-ubuntu-nginx-hhvm:latest
MAINTAINER "Youngho Byun (echoes)" <elend80@gmail.com>

ENV TERM xterm

RUN rm -rf /var/www/html

ADD nginx.conf /etc/nginx/nginx.conf

ADD default /etc/nginx/sites-available/default

RUN adduser www-data www-data

# Wordpress

ADD https://wordpress.org/latest.tar.gz /tmp/latest.tar.gz
RUN cd tmp && tar xvf latest.tar.gz && \
    mv /tmp/wordpress/* /var/www && \
    rm -rf wordpress/* && \
    rm latest.tar.gz && \
    chown -R www-data:www-data /var/www

ADD wp-config-sample.php /var/www/wp-config-sample.php

EXPOSE 80
EXPOSE 443

CMD ["/usr/bin/supervisord"]
