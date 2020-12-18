# Bash script for generating passwords.
# 2020, Ivan Kmeťo
#
# CC0 1.0 Universal (CC0 1.0) Public Domain Dedication
# https://creativecommons.org/publicdomain/zero/1.0/

install:
	cp genpwdsh/genpwdsh.sh /usr/local/bin/genpwdsh
	chmod a+rx /usr/local/bin/genpwdsh
	cp genpwdsh/genpwdsh.1 /usr/share/man/man1/genpwdsh.1

uninstall:
	rm /usr/local/bin/genpwdsh /usr/share/man/man1/genpwdsh.1