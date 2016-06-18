# Drupal 7 Docker base image

[Dockerfile](https://github.com/karelbemelmans/d7-docker-base/blob/master/Dockerfile)

This Dockerfile is used as the base image for my other Drupal 7 containers. It contains a base set of PHP extensions, PECL modules, Drupal themes, Drupal modules and Drupal libraries that are common to all Drupal sites.

Currently this Dockerfile includes:

  - The base official Drupal 7 Apache image (`FROM drupal:7-apache`)
  - The `unzip` Debian package
  - The PECL memcached extension
  - The following Drupal modules:
    - memcached
    - libraries
  - The following Drupal themes:
    - <none>
  - The following Drupal libraries:
    - <none>
