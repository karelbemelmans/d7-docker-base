FROM drupal:7-apache
MAINTAINER Karel Bemelmans <mail@karelbemelmans.com>

# Add some extra packages we need in this file
#
# The drush versie that debian:jessie (which the drupal base image uses) is a very
# old one. But we only use it to download modules, not actually perform database
# updates so it's ok for us to just use that old version.
RUN apt-get update && apt-get install -y unzip drush \
  && rm -rf /var/lib/apt/lists/*

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

# Add Drupal modules, used for development purpose
RUN mkdir sites/all/modules/development \
  && drush dl coder-7.x-2.5 devel schema --destination=sites/all/modules/development

# Add Drupal modules, generic contrib
RUN mkdir sites/all/modules/contrib \
  && drush dl context ctools date ds entity features google_analytics \
              libraries memcache pathauto strongarm token transliteration \
              variable views views_bulk_operations wysiwyg-7.x-2.x-dev \
              xmlsitemap content_menu menu_block menu_position cdn smtp

# Multilingual
RUN drush dl entity_translation i18n i18nviews l10n_update title

# Add Drupal themes
RUN mkdir sites/all/themes/contrib && drush dl mothership

# Add Drupal libraries

# Done.
