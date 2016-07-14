<?php

////////////////////////////////////////////////////////////////////////////////
// Database
$databases['default']['default'] = array(
  'driver'   => 'mysql', // since everyone uses MySQL we can hardcode this
  'database' => $_ENV['DRUPAL_DB_NAME'],
  'username' => $_ENV['DRUPAL_DB_USER'],
  'password' => $_ENV['DRUPAL_DB_PASS'],
  'host'     => $_ENV['DRUPAL_DB_HOST'],
  'prefix'   => !empty($_ENV['DRUPAL_DB_PREFIX']) ? $_ENV['DRUPAL_DB_PREFIX'] : '',
);

////////////////////////////////////////////////////////////////////////////////
// Redis configuration

if (isset($_SERVER['DRUPAL_REDIS_HOST']) && !empty($_SERVER['DRUPAL_REDIS_HOST']) &&
  isset($_SERVER['DRUPAL_REDIS_PORT']) && !empty($_SERVER['DRUPAL_REDIS_PORT'])) {

  $conf['redis_client_interface'] = 'PhpRedis'; // Can be "Predis".
  $conf['redis_client_host']      = $_SERVER['DRUPAL_REDIS_HOST'];  // Your Redis instance hostname.
  $conf['redis_client_port']      = $_SERVER['DRUPAL_REDIS_PORT'];  // Your Redis instance hostname.
  $conf['lock_inc']               = 'sites/all/modules/contrib/redis/redis.lock.inc';
  $conf['path_inc']               = 'sites/all/modules/contrib/redis/redis.path.inc';
  $conf['cache_backends'][]       = 'sites/all/modules/contrib/redis/redis.autoload.inc';
  $conf['cache_default_class']    = 'Redis_Cache';
}

// This is a very basic memcached setup where there is one cache in and
// everything goes into this bin. If you want to have a more specific caching
// strategy, override the settings.php file in your own container.
$conf['memcache_servers'] = array(
  $_ENV['DRUPAL_MEMCACHE_HOST'] . ':' . $_ENV['DRUPAL_MEMCACHE_PORT'] => 'default'
);

// Enforce SSL if the HTTP_X_FORWARDED_PROTO tell us to.
if ($_SERVER['HTTP_X_FORWARDED_PROTO'] == 'https') {
  $base_url = 'https://'.$_SERVER['SERVER_NAME'];
}

// Is there an extra.settings.php file to include?
$settings = DRUPAL_ROOT . '/sites/default/extra.settings.php';
if (file_exists($settings)) {
 require_once($settings);
}
