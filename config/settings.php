<?php

////////////////////////////////////////////////////////////////////////////////
// Database
$databases['default']['default'] = array(
  'driver'   => 'mysql', // since everyone uses MySQL we can hardcode this
  'database' => $_ENV['DRUPAL_DB_NAME'],
  'username' => $_ENV['DRUPAL_DB_USER'],
  'password' => $_ENV['DRUPAL_DB_PASS'],
  'host'     => $_ENV['DRUPAL_DB_HOST'],
  'prefix'   => $_ENV['DRUPAL_DB_PREFIX'],
);

////////////////////////////////////////////////////////////////////////////////
// Memcache configuration
$conf['cache_backends'][] = 'sites/all/modules/contrib/memcache/memcache.inc';
$conf['lock_inc'] = 'sites/all/modules/contrib/memcache/memcache-lock.inc';
$conf['memcache_stampede_protection'] = TRUE;
$conf['cache_default_class'] = 'MemCacheDrupal';

// The 'cache_form' bin must be assigned no non-volatile storage.
$conf['cache_class_cache_form'] = 'DrupalDatabaseCache';

// Don't bootstrap the database when serving pages from the cache.
$conf['page_cache_without_database'] = TRUE;
$conf['page_cache_invoke_hooks'] = FALSE;

// This is a very basic memcached setup where there is one cache in and
// everything goes into this bin. If you want to have a more specific caching
// strategy, override the settings.php file in your own container.
$conf['memcache_servers'] = array(
  $_ENV['DRUPAL_MEMCACHE_HOST'] . ':' . $_ENV['DRUPAL_MEMCACHE_PORT'] => 'default'
);

// Is there an extra.settings.php file to include?
$settings = DRUPAL_ROOT . '/sites/default/extra.settings.php';
if (file_exists($settings)) {
 require_once($settings);
}
