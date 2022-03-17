#!/bin/bash

# Bash script for generating passwords.
# 2020 - 2022, Ivan Kmeťo
#
# CC0 1.0 Universal (CC0 1.0) Public Domain Dedication
# https://creativecommons.org/publicdomain/zero/1.0/

# Usage: genpwdsh [LENGTH] [METHOD] [INPUT]
# Methods: -sha224 | -sha256 | -sha384 | -sha512 | -b2 | -random | -urandom | -openssl | -gpg


length=$1
method=$2
input=$3


if [ $# = 0 ]; then
  length=8
  method=-b2
  input="date +%N%M%S"
elif [ $# = 1 ]; then
  if [ $1 = --help ]; then
    echo "Usage: genpwdsh [LENGTH] [METHOD] [INPUT]"
    echo "Bash script for generating passwords."
    echo
    echo "Available methods for generating passwords:"
    echo "-sha224 | -sha256 | -sha384 | -sha512 | -b2 | -random | -urandom | -openssl | -gpg"
    exit 0
  elif [ $1 = --version ]; then
    echo "GenPwdSh 1.2.0"
    echo "2020 - 2022, Ivan Kmeťo"
    echo "CC0 1.0 Universal (CC0 1.0) Public Domain Dedication"
    exit 0
  else
    method=-b2
    input="date +%N%M%S"
  fi
elif [ $# = 2 ]; then
  input="date +%N%M%S"
fi


if [ $length -lt 1 ]
then
  echo 1>&2 "$0: Length must be greater than 0."
  exit 2
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
