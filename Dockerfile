FROM drupal:7-apache
MAINTAINER Karel Bemelmans <mail@karelbemelmans.com>

# Add some extra packages we need in this file
RUN apt-get update && apt-get install -y unzip && rm -rf /var/lib/apt/lists/*

# Create the sites/default/files folder so Drupal can write caches to it
RUN mkdir -p sites/default/files && chown www-data:www-data sites/default/files

# Add pecl memcache module
RUN apt-get update && apt-get install -y libmemcached-dev \
  && pecl install memcached \
  && docker-php-ext-enable memcached

# Change some PHP defaults.
RUN { \
    echo 'date.timezone = Europe/Stockholm'; \
  } > /usr/local/etc/php/conf.d/drupal-base.ini

# Remove some files from the Drupal base install.
RUN rm CHANGELOG.txt COPYRIGHT.txt INSTALL.mysql.txt INSTALL.pgsql.txt \
       INSTALL.sqlite.txt INSTALL.txt LICENSE.txt MAINTAINERS.txt \
       README.txt UPGRADE.txt

# Copy our local settings.php file into the container.
# This file uses a lot of environment variables to connect to services (db, cache)
COPY config/settings.php sites/default/settings.php

# Install our Drupal 7 download helper script. This downloads files from Drupal.org
# and checks the MD5 sums for correctness after downloading.
COPY bin/d7download.sh /usr/local/bin/d7download.sh

# Add Drupal modules, used for development purpose
RUN d7download.sh modules coder      7.x-2.5   e69d278b983464be1ba0eabcec955334 \
 && d7download.sh modules devel      7.x-1.5   f06c912eb4edbd48fbcc2867516726a3

# Add Drupal modules, generic contrib
RUN d7download.sh modules context    7.x-3.7   7486753eef5a1496a3aa79ce7f168124 \
 && d7download.sh modules ctools     7.x-1.9   bd7b5dac915e8fa3da909379807ef824 \
 && d7download.sh modules ds         7.x-2.14  82193cb185ab89530b356a2022503de4 \
 && d7download.sh modules features   7.x-2.10  5641e5545020932570aed464fbaebf6a \
 && d7download.sh modules libraries  7.x-2.3   294d3e4096c513321159b908cfd7c2be \
 && d7download.sh modules memcache   7.x-1.5   3ea99c76b6429f0bbc8f922cd91eb459 \
 && d7download.sh modules views      7.x-3.14  168bb684c8f34297be94b03c797841e5

# Add Drupal themes
RUN d7download.sh themes mothership  7.x-2.10  529df1ef77532df08b46fae12a5eaaaa

# Add Drupal libraries

# Done.
