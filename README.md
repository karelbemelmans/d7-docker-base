# Drupal 7 Docker base image

This Dockerfile is used as the base image for Drupal 7 container. It contains a base set of PHP extensions, PECL modules, Drupal themes, Drupal modules and Drupal libraries that are common to all Drupal sites.

Currently this Dockerfile includes:

  - The base official Drupal 7 Apache image (`FROM drupal:7-apache`)
  - The `unzip` Debian package
  - The PECL memcached extension and the Drupal memcached module
  - The following Drupal modules:
    - libraries
  - The following Drupal themes:
    - <none>
  - The following Drupal libraries:
    - <none>
