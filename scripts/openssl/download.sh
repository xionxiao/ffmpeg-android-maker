#!/usr/bin/env bash

source ${SCRIPTS_DIR}/common-functions.sh

OPENSSL_VERSION=1.1.1k

downloadTarArchive \
  "openssl" \
  "https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz"
