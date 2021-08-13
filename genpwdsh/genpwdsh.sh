#!/bin/bash

# Bash script for generating passwords.
# 2020-2021, Ivan Kmeťo
#
# CC0 1.0 Universal (CC0 1.0) Public Domain Dedication
# https://creativecommons.org/publicdomain/zero/1.0/

# Use: genpwdsh [length] [method]
# Methods: -sha256 | -sha512 | -md5 | -random  | -urandom | -openssl | -gpg


if [ $# -lt 2 ]; then
  echo 1>&2 "$0: Not enough arguments."
  echo 1>&2 "$0: Use: genpwdsh [length] [method]"
  exit 2
elif [ $# -gt 2 ]; then
  echo 1>&2 "$0: Too many arguments."
  echo 1>&2 "$0: Use: genpwdsh [length] [method]"
  exit 2
fi

length=$1
method=$2

if [ $length -lt 1 ]
then
  echo 1>&2 "$0: Length must be greater than 0."
else
  if [ $method = -sha256 ]
  then
    date +%s | sha256sum | base64 | head -c $length ; echo
  elif [ $method = -sha512 ]
  then
    date +%s | sha512sum | base64 | head -c $length ; echo
  elif [ $method = -md5 ]
  then
    date +%s | md5sum -z | head -c $length ; echo;
  elif [ $method = -random ]
  then
    < /dev/random tr -dc _A-Z-a-z-0-9 | head -c${1:-$length}; echo;
  elif [ $method = -urandom ]
  then
    < /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-$length}; echo;
  elif [ $method = -openssl ]
  then
    openssl rand -base64 $length
  elif [ $method = -gpg ]
  then
    gpg --gen-random --armor 2 $length
  else
    echo 1>&2 "$0: Unknown method."
    exit 2
  fi
fi
