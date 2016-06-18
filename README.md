# Drupal 7 Docker base image

This Dockerfile is used as the base image for my other Drupal Dockerfiles.

This base image contains a base set of PHP extensions, PECL modules, Drupal
themes, Drupal modules and Drupal libraries that are common to all Drupal sites.

Currently this Dockerfile includes:

  - The base official Drupal 7 Apache image
  - The unzip Debian package
  - The PECL memcached extension and the Drupal memcached module
  - The following Drupal modules:
    - libraries
  - The following Drupal themes:
    - <none>
  - The following Drupal libraries:
    - <none>
