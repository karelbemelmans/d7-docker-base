#!/bin/bash
#
# Download modules, themes or libraries from Drupal.org
# Verify the supplied MD5 when downloading a tar.gz file.
#
# Usage: d7download.sh type name version MD5
#   type: modules, themes or libraries
#   name: the name of the module as on drupal.org
#   version: the version of the module e.g. 7.x-1.2
#   MD5 checksum of the downloaded .tar.gz

LOCATION=$1
NAME=$2
VERSION=$3
MD5=$4

mkdir -p sites/all/${LOCATION}/contrib/${NAME} \
  && curl -Lks https://ftp.drupal.org/files/projects/${NAME}-${VERSION}.tar.gz \
       -o /tmp/${NAME}-${VERSION}.tar.gz \
  && echo "${MD5} /tmp/${NAME}-${VERSION}.tar.gz" | md5sum -c - \
  && tar --strip=1 -xzf /tmp/${NAME}-${VERSION}.tar.gz -C sites/all/${LOCATION}/contrib/${NAME} \
  && rm /tmp/${NAME}-${VERSION}.tar.gz
