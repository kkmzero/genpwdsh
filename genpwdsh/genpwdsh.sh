#!/bin/bash

# Bash script for generating passwords.
# 2020 - 2021, Ivan Kmeťo
#
# CC0 1.0 Universal (CC0 1.0) Public Domain Dedication
# https://creativecommons.org/publicdomain/zero/1.0/

# Usage: genpwdsh [LENGTH] [METHOD]
# Methods: -sha224 | -sha256 | -sha384 | -sha512 | -b2 | -md5 | -random | -urandom | -openssl | -gpg


if [ $# = 0 ]; then
  echo 1>&2 "$0: Not enough arguments."
  echo "Try 'genpwdsh --help' for more information."
  exit 2
fi

if [ $1 = --help ]; then
  echo "Usage: genpwdsh [LENGTH] [METHOD]"
  echo "Bash script for generating passwords."
  echo
  echo "Available methods for generating passwords:"
  echo "-sha224 | -sha256 | -sha384 | -sha512 | -b2 | -md5 | -random | -urandom | -openssl | -gpg"
  exit 0
elif [ $1 = --version ]; then
  echo "GenPwdSh 1.1.0"
  echo "2020 - 2021, Ivan Kmeťo"
  echo "CC0 1.0 Universal (CC0 1.0) Public Domain Dedication"
  exit 0
fi

if [ $# -lt 2 ]; then
  echo 1>&2 "$0: Not enough arguments."
  echo "Try 'genpwdsh --help' for more information."
  exit 2
elif [ $# -gt 2 ]; then
  echo 1>&2 "$0: Too many arguments."
  echo "Try 'genpwdsh --help' for more information."
  exit 2
fi

length=$1
method=$2

input="date +%s"


if [ $length -lt 1 ]
then
  echo 1>&2 "$0: Length must be greater than 0."
else
  if [ $method = -sha224 ]
  then
    $input | sha224sum | base64 | head -c $length; echo
  elif [ $method = -sha256 ]
  then
    $input | sha256sum | base64 | head -c $length; echo
  elif [ $method = -sha384 ]
  then
    $input | sha384sum | base64 | head -c $length; echo
  elif [ $method = -sha512 ]
  then
    $input | sha512sum | base64 | head -c $length; echo
  elif [ $method = -b2 ]
  then
    $input | b2sum | base64 | head -c $length; echo
  elif [ $method = -md5 ]
  then
    $input | md5sum -z | head -c $length; echo;
  elif [ $method = -random ]
  then
    < /dev/random tr -dc _A-Z-a-z-0-9 | head -c${1:-$length}; echo;
  elif [ $method = -urandom ]
  then
    < /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-$length}; echo;
  elif [ $method = -openssl ]
  then
    openssl rand -base64 $length | head -c $length; echo;
  elif [ $method = -gpg ]
  then
    gpg --gen-random --armor 2 $length | head -c $length; echo;
  else
    echo 1>&2 "$0: Unknown method."
    echo "Try 'genpwdsh --help' for more information."
    exit 2
  fi
fi
