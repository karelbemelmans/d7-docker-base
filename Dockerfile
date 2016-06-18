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

# Install our Drupal 7 download helper script. This download files from Drupal.org
# and checks the MD5 sums for correctness after downloading.
COPY bin/d7download.sh /usr/local/bin/d7download.sh

# Add memcached contrib module
RUN /usr/local/bin/d7download.sh modules memcache 7.x-1.5 3ea99c76b6429f0bbc8f922cd91eb459

# Add Libraries contrib module
RUN /usr/local/bin/d7download.sh modules libraries 7.x-2.3 294d3e4096c513321159b908cfd7c2be

