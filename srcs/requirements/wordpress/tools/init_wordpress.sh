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
	wp-cli-release.phar --allow-root --path="/var/www/wordpress" core install --title="Test title" --admin_name="$WP_ADMIN_NAME" --admin_password="$WP_ADMIN_PASSWORD" --admin_email="$WP_ADMIN_EMAIL" --skip-email --url="https://mvan-wij.42.fr/wordpress"
else
	echo "Wordpress already initialized"
fi

echo "Running: [$@]"
exec "$@"
