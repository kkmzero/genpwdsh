# GenPwdSh

Bash script for generating passwords, released to the [public domain](LICENSE).

## Installation
Use command ```make install``` to copy file *genpwdsh.sh* to */usr/local/bin/genpwdsh* path. Alternatively, you can uninstall genpwdsh by using ```make uninstall``` command. Default install paths can be changed by editing variables ```DEST_PATH``` and ```MAN_PATH``` in the Makefile.

## Arguments
```genpwdsh [LENGTH] [METHOD] [INPUT]```

#### Length
Length limit of desired password set as integer greater than 0. Default value is 16.</br>
#### Method
Specifies method of generating passwords:</br>
-b2 | -sha224 | -sha256 | -sha384 | -sha512 | -shake128 | -shake256 | -random | -urandom | -openssl | -gpg</br>
Default method is *-openssl*.
#### Input
Specifies custom input value. By default, output of command ```date +%N%M%S``` is used as input value.

## Examples
```
$ genpwdsh
Tt0Yj3RySbXsSVPh
```

```
$ genpwdsh 32
Ea55e6KZZd2bf4grJUBeIk8pNLH2wCES
```

```
$ genpwdsh 8 -urandom
Sura^6%R
```

```
$ genpwdsh 12 -shake256 "echo HelloWorld"
MmY4ZDk3MzQ5
```
