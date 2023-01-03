FROM debian:buster

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y php-fpm wget php-mysql

RUN wget https://wordpress.org/wordpress-6.1.1.tar.gz && \
	wget https://raw.githubusercontent.com/wp-cli/builds/3e345df698faea02d64baebcb2fa6fc523231494/phar/wp-cli-release.phar

COPY conf/ /tmp/wordpress

RUN tar xzf wordpress-6.1.1.tar.gz --directory /tmp/wordpress

RUN sed 's/listen = \/run\/php\/php7.3-fpm.sock/listen = 0.0.0.0:9000/' -i /etc/php/7.3/fpm/pool.d/www.conf

EXPOSE 9000

CMD cp -a /tmp/wordpress/* /var/www && tail -f && \
	php wp-cli-release.phar core install --allow-root --title="Test title" --admin_name="mvan-wij" --admin_password="verysafepassword" --path="/var/www/wordpress" --url="http://localhost/wordpress" && \
	php-fpm7.3 -F -R
# FIXME: change to https
# CMD tail -f
