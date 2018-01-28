<?php


// FIRST: check for required env vars
$requiredAll = [
    'WORDPRESS_MYSQL_DB_URL',
    'WORDPRESS_TABLE_PREFIX',
    'WORDPRESS_HOME_URL',
];
foreach($requiredAll as $requiredVar) {
    if(!getenv($requiredVar)) {
        echo "required:";
        print_r($requiredAll);
        die("Environment Variable $requiredVar is not set");
    }
}


/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://codex.wordpress.org/Editing_wp-config.php
 *
 * @package WordPress
 */

$database_url = getenv('WORDPRESS_MYSQL_DB_URL');
// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define('DB_NAME', explode('/', parse_url($database_url, PHP_URL_PATH))[1]);

/** MySQL database username */
define('DB_USER', parse_url($database_url, PHP_URL_USER));

/** MySQL database password */
define('DB_PASSWORD', parse_url($database_url, PHP_URL_PASS));

/** MySQL hostname */
define('DB_HOST', parse_url($database_url, PHP_URL_HOST));

/** Database Charset to use in creating database tables. */
define('DB_CHARSET', 'utf8');

/** The Database Collate type. Don't change this if in doubt. */
define('DB_COLLATE', '');

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
require(getenv('WORDPRESS_SALTS_PATH'));
/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = getenv('WORDPRESS_TABLE_PREFIX');

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the Codex.
 *
 * @link https://codex.wordpress.org/Debugging_in_WordPress
 */
if(getenv('WORDPRESS_WP_DEBUG')) {
    define('WP_DEBUG', true);
    define('WP_DEBUG_DISPLAY', true);
    error_reporting(E_ALL);
    ini_set('display_errors', 1);
}

/**
 * Container Additions
 */

define('FS_METHOD', 'direct');
$baseUrl = getenv('WORDPRESS_HOME_URL');
define('WP_HOME', $baseUrl);
define('WP_SITEURL', $baseUrl . '/wp');
define('WP_CONTENT_DIR', getenv('WEB_ROOT'));
define('WP_CONTENT_URL', $baseUrl);

/**
 * Handle SSL reverse proxy (from https://www.variantweb.net/blog/wordpress-behind-an-nginx-ssl-reverse-proxy/)
 */
if($_SERVER['HTTP_X_FORWARDED_PROTO']??'' == 'https') {
    $_SERVER['HTTPS'] = 'on';
}

if(isset($_SERVER['HTTP_X_FORWARDED_HOST'])) {
    $_SERVER['HTTP_HOST'] = $_SERVER['HTTP_X_FORWARDED_HOST'];
}


/* That's all, stop editing! Happy blogging. */

/** Absolute path to the WordPress directory. */
if(!defined('ABSPATH')) {
    define('ABSPATH', getenv('WORDPRESS_ABS_PATH'));
}

/** Sets up WordPress vars and included files. */
require_once(ABSPATH . 'wp-settings.php');
