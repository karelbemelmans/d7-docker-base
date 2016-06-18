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

# Add memcached contrib module
ENV MEMCACHE_VERSION 7.x-1.5
ENV MEMCACHE_MD5 3ea99c76b6429f0bbc8f922cd91eb459

RUN mkdir -p sites/all/modules/contrib/memcache \
  && curl -Lks https://ftp.drupal.org/files/projects/memcache-${MEMCACHE_VERSION}.tar.gz \
       -o /tmp/memcache-${MEMCACHE_VERSION}.tar.gz \
  && echo "${MEMCACHE_MD5} /tmp/memcache-${MEMCACHE_VERSION}.tar.gz" | md5sum -c - \
  && tar --strip=1 -xzf /tmp/memcache-${MEMCACHE_VERSION}.tar.gz -C sites/all/modules/contrib/memcache \
  && rm /tmp/memcache-${MEMCACHE_VERSION}.tar.gz

# Add Libraries contrib module
ENV LIBRARIES_VERSION 7.x-2.3
ENV LIBRARIES_MD5 294d3e4096c513321159b908cfd7c2be

RUN mkdir -p sites/all/modules/contrib/libraries \
  && curl -Lks https://ftp.drupal.org/files/projects/libraries-${LIBRARIES_VERSION}.tar.gz \
       -o /tmp/libraries-${LIBRARIES_VERSION}.tar.gz \
  && echo "${LIBRARIES_MD5} /tmp/libraries-${LIBRARIES_VERSION}.tar.gz" | md5sum -c - \
  && tar --strip=1 -xzf /tmp/libraries-${LIBRARIES_VERSION}.tar.gz -C sites/all/modules/contrib/libraries \
  && rm /tmp/libraries-${LIBRARIES_VERSION}.tar.gz

