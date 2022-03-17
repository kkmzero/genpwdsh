# GenPwdSh

Bash script for generating passwords, released to the [public domain](LICENSE).

### Installation
Use ```(sudo) make install``` to copy file *genpwdsh.sh* to */usr/local/bin/genpwdsh*. Alternatively, you can uninstall genpwdsh by using ```make uninstall``` command.

### Arguments
```genpwdsh [LENGTH] [METHOD] [INPUT]```

**Length**: Length limit of desired password. Can not be less than or equal to 0.</br>
**Method**: Specifies method of generating passwords: -sha224 | -sha256 | -sha384 | -sha512 | -b2 | -random | -urandom | -openssl | -gpg</br>
**Input**: Specifies custom input value. By default, output of command ```date +%N%M%S``` is used.
