FROM debian:stable

RUN apt-get update; \
	apt-get upgrade -y; \
	apt-get install -y php-fpm wget php-mysql

RUN wget https://wordpress.org/wordpress-6.1.1.tar.gz; \
	wget https://raw.githubusercontent.com/wp-cli/builds/3e345df698faea02d64baebcb2fa6fc523231494/phar/wp-cli-release.phar

COPY conf/ /tmp/wordpress

RUN tar xzf wordpress-6.1.1.tar.gz --directory /tmp/wordpress

RUN mkdir -p /run/php
RUN sed 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 0.0.0.0:9000/' -i /etc/php/7.4/fpm/pool.d/www.conf

EXPOSE 9000

COPY tools/init_wordpress.sh /usr/bin/init_wordpress.sh
RUN chmod 777 /usr/bin/init_wordpress.sh

ENTRYPOINT [ "init_wordpress.sh" ]
CMD [ "php-fpm7.4", "-F" ]
