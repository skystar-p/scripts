#!/usr/bin/env python

import secrets
import string
import sys


if len(sys.argv) < 2:
    sys.stderr.write('usage: pwgen <length>\n')
    exit(1)

try:
    length = int(sys.argv[1])
except ValueError:
    sys.stderr.write('usage: pwgen <length>\n')
    exit(1)

charset = string.ascii_letters + string.digits
password = ''

for _ in range(length):
    password += secrets.choice(charset)

print(password)
