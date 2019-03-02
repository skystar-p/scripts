#!/usr/bin/env python

import secrets
import string
import argparse


parser = argparse.ArgumentParser()
parser.add_argument('--special', '-s',
                    action='store_true', help='add special characters')
parser.add_argument('length', help='password length')
args = parser.parse_args()

length = int(args.length)

charset = string.ascii_letters + string.digits
if args.special:
    charset += string.punctuation

password = ''

for _ in range(length):
    password += secrets.choice(charset)

print(password)
