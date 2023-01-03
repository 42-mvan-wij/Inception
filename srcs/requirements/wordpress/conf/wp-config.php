<?php

define( 'DB_NAME', 'wordpress' );
define( 'DB_USER', 'mvan-wij' );
define( 'DB_PASSWORD', 'verysafepassword' );
define( 'DB_HOST', 'mariadb' );
define( 'DB_CHARSET', 'utf8mb4' );

// The Database Collate type. Don't change this if in doubt.
define( 'DB_COLLATE', '' );

define( 'AUTH_KEY',				'verysafesalt' );
define( 'SECURE_AUTH_KEY',		'verysafesalt' );
define( 'LOGGED_IN_KEY',		'verysafesalt' );
define( 'NONCE_KEY',			'verysafesalt' );
define( 'AUTH_SALT',			'verysafesalt' );
define( 'SECURE_AUTH_SALT',		'verysafesalt' );
define( 'LOGGED_IN_SALT',		'verysafesalt' );
define( 'NONCE_SALT',			'verysafesalt' );

$table_prefix = 'wp_';

define( 'WP_DEBUG', true );

if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', dirname( __FILE__ ) . '/' );
}

require_once( ABSPATH . 'wp-settings.php' );

?>
