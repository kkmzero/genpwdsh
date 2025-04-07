#!/bin/bash

# Bash script for generating passwords.
# 2020 - 2025, Ivan Kmeťo
#
# CC0 1.0 Universal (CC0 1.0) Public Domain Dedication
# https://creativecommons.org/publicdomain/zero/1.0/

# Usage: genpwdsh [LENGTH] [METHOD] [INPUT]
# Methods: -b2 | -b3 | -sha224 | -sha256 | -sha384 | -sha512 | -shake128 | -shake256 | -random | -urandom | -openssl | -gpg

length=$1
method=$2
input=$3

if [ $# = 0 ]; then
  length=16
  method=-openssl
  input="date +%N%M%S"
elif [ $# = 1 ]; then
  if [ $1 = --help ]; then
    echo "Usage: genpwdsh [LENGTH] [METHOD] [INPUT]"
    echo "Bash script for generating passwords."
    echo
    echo "Available methods for generating passwords:"
    echo "-b2 | -b3 | -sha224 | -sha256 | -sha384 | -sha512 | -shake128 | -shake256 | -random | -urandom | -openssl | -gpg"
    exit 0
  elif [ $1 = --version ]; then
    echo "GenPwdSh 1.3.0"
    echo "2020 - 2025, Ivan Kmeťo"
    echo "CC0 1.0 Universal (CC0 1.0) Public Domain Dedication"
    exit 0
  else
    method=-openssl
    input="date +%N%M%S"
  fi
elif [ $# = 2 ]; then
  input="date +%N%M%S"
fi


if ! [ $length -eq $length ] 2> /dev/null || [ $length -lt 1 ]
then
  echo 1>&2 "$0: Length must be integer greater than 0."
  echo "Try 'genpwdsh --help' for more information."
  exit 2
else
  if [ $method = -sha224 ]
  then
    $input | openssl dgst -sha3-224 -r | base64 | head -c $length; echo
  elif [ $method = -sha256 ]
  then
    $input | openssl dgst -sha3-256 -r | base64 | head -c $length; echo
  elif [ $method = -sha384 ]
  then
    $input | openssl dgst -sha3-384 -r | base64 | head -c $length; echo
  elif [ $method = -sha512 ]
  then
    $input | openssl dgst -sha3-512 -r | base64 | head -c $length; echo
  elif [ $method = -b2 ]
  then
    $input | openssl dgst -blake2b512 -r | base64 | head -c $length; echo
  elif [ $method = -shake128 ]
  then
    $input | openssl dgst -shake128 -r | base64 | head -c $length; echo
  elif [ $method = -shake256 ]
  then
    $input | openssl dgst -shake256 -r | base64 | head -c $length; echo
  elif [ $method = -random ]
  then
    < /dev/random tr -dc 'A-Za-z0-9!"#$%&'\''()*+,-./:;<=>?@[\]^_`{|}~' | head -c${1:-$length}; echo;
  elif [ $method = -urandom ]
  then
    < /dev/urandom tr -dc 'A-Za-z0-9!"#$%&'\''()*+,-./:;<=>?@[\]^_`{|}~' | head -c${1:-$length}; echo;
  elif [ $method = -openssl ]
  then
    openssl rand -base64 $length | head -c $length; echo;
  elif [ $method = -gpg ]
  then
    gpg --gen-random --armor 2 $length | head -c $length; echo;
  elif [ $method = -b3 ]
  then
    $input | b3sum | base64 | head -c $length; echo
  else
    echo 1>&2 "$0: Unknown method."
    echo "Try 'genpwdsh --help' for more information."
    exit 2
  fi
fi
