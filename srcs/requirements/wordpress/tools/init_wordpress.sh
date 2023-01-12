#!/bin/sh

if [ ! -d /var/www/wordpress ]; then
	echo "Installing wordpress"
	tar xzf /tmp/wordpress/wordpress-6.1.1.tar.gz --directory /var/www
else
	echo "Wordpress already installed"
fi

if [ ! -f /var/www/wordpress/wp-config.php ]; then
	echo "Initializing wordpress"
	cp /tmp/wordpress/wp-config.php /var/www/wordpress
	wp-cli-release.phar core install --allow-root --title="Test title" --admin_name="$WP_USER" --admin_password="$WP_PASSWORD" --admin_email="$WP_EMAIL" --skip-email --path="/var/www/wordpress" --url="https://localhost/wordpress"
else
	echo "Wordpress already initialized"
fi

echo "Running: [$@]"
exec "$@"
