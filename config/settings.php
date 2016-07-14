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

// Enforce SSL if the HTTP_X_FORWARDED_PROTO tell us to.
if ($_SERVER['HTTP_X_FORWARDED_PROTO'] == 'https') {
  $base_url = 'https://'.$_SERVER['SERVER_NAME'];
}

// Is there an extra.settings.php file to include?
$settings = DRUPAL_ROOT . '/sites/default/extra.settings.php';
if (file_exists($settings)) {
 require_once($settings);
}
