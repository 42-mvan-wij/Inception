#!/bin/sh

if [ ! -d /var/www/wordpress ]; then
	echo "Installing wordpress"
	tar xzf wordpress-6.1.1.tar.gz --directory /var/www
else
	echo "Wordpress already installed"
fi

if [ ! -f /var/www/wp-config.php ]; then
	echo "Initializing wordpress"
	cp /tmp/wordpress/wp-config.php /var/www
	php wp-cli-release.phar core install --allow-root --title="Test title" --admin_name="$WP_USER" --admin_password="$WP_PASSWORD" --admin_email="$WP_EMAIL" --skip-email --path="/var/www/wordpress" --url="http://localhost/wordpress"
	# FIXME: change to https
else
	echo "Wordpress already initialized"
fi

echo "Running: <$@>"
exec "$@"
