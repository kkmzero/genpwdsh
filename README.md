# genpwdsh

Bash script for generating passwords, released to the [public domain](LICENSE).

### Installation
Use ```(sudo) make install``` to copy file *genpwdsh.sh* to */usr/local/bin/genpwdsh*. Alternatively, you can uninstall genpwdsh by using ```make uninstall``` command.

### Functions
```genpwdsh [length] [method]```

**Length**: Length of desired password. Can not be less than or equal to 0.</br>
**Method**: Method of generating passwords: -sha256 | -sha512 | -urandom | -openssl | -gpg
