<?php

define( 'DB_NAME',			getenv('MARIADB_DATABASE') );
define( 'DB_USER',			getenv('MARIADB_USER') );
define( 'DB_PASSWORD',		getenv('MARIADB_PASSWORD') );
define( 'DB_HOST',			getenv('MARIADB_HOST') );
define( 'DB_CHARSET',		'utf8' );

// The Database Collate type. Don't change this if in doubt.
define( 'DB_COLLATE',		'' );

define( 'AUTH_KEY',			getenv('WP_AUTH_KEY') );
define( 'SECURE_AUTH_KEY',	getenv('WP_SECURE_AUTH_KEY') );
define( 'LOGGED_IN_KEY',	getenv('WP_LOGGED_IN_KEY') );
define( 'NONCE_KEY',		getenv('WP_NONCE_KEY') );
define( 'AUTH_SALT',		getenv('WP_AUTH_SALT') );
define( 'SECURE_AUTH_SALT',	getenv('WP_SECURE_AUTH_SALT') );
define( 'LOGGED_IN_SALT',	getenv('WP_LOGGED_IN_SALT') );
define( 'NONCE_SALT',		getenv('WP_NONCE_SALT') );

$table_prefix = 'wp_';

define( 'WP_DEBUG', true );

if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', dirname( __FILE__ ) . '/' );
}

require_once( ABSPATH . 'wp-settings.php' );

?>
