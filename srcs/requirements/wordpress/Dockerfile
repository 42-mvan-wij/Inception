FROM debian:stable

RUN apt-get update; \
	apt-get upgrade -y; \
	apt-get install -y php-fpm php-mysql

COPY conf/ /tmp/wordpress

ADD https://wordpress.org/wordpress-6.1.1.tar.gz /tmp/wordpress/
ADD https://raw.githubusercontent.com/wp-cli/builds/3e345df698faea02d64baebcb2fa6fc523231494/phar/wp-cli-release.phar /usr/bin/
RUN chmod 777 /usr/bin/wp-cli-release.phar

RUN mkdir -p /run/php

RUN sed 's/listen = .*/listen = wordpress:9000/' -i /etc/php/7.4/fpm/pool.d/www.conf
RUN sed 's/;clear_env = no/clear_env = no/' -i /etc/php/7.4/fpm/pool.d/www.conf

EXPOSE 9000

COPY tools/init_wordpress.sh /usr/bin/init_wordpress.sh
RUN chmod 777 /usr/bin/init_wordpress.sh

ENTRYPOINT [ "init_wordpress.sh" ]
CMD [ "php-fpm7.4", "-F" ]
