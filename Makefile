# Bash script for generating passwords.
# 2020 - 2025, Ivan Kmeťo
#
# CC0 1.0 Universal (CC0 1.0) Public Domain Dedication
# https://creativecommons.org/publicdomain/zero/1.0/


DEST_PATH = /usr/local/bin
MAN_PATH  = /usr/share/man/man1

MANPAGE ?= y

install:
	cp genpwdsh/genpwdsh.sh $(DEST_PATH)/genpwdsh
	chmod a+rx $(DEST_PATH)/genpwdsh

    ifeq  ($(MANPAGE),y)
	cp genpwdsh/genpwdsh.1 $(MAN_PATH)/genpwdsh.1
    endif

uninstall:
	rm $(DEST_PATH)/genpwdsh $(MAN_PATH)/genpwdsh.1
