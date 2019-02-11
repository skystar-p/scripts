#!/bin/bash

readonly USER="usezmap@gmail.com"

function usage() {
    echo "usage: otp <site>"
    echo "  <site>      name of the site"
}

function errecho() {
    >&2 echo "$@"
}

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
SITE=$1

if [[ $# -ne 1 ]]; then
    usage
    exit 1
fi

readonly FILE="$DIR/sites/$SITE.encrypted"

if ! [[ -f $FILE ]]; then
    errecho "No such site"
    exit 1
fi

CODE=$(cat $FILE | gpg --decrypt --quiet 2>/dev/null)

TOKEN=$(oathtool --base32 --totp "$CODE")
echo -n $TOKEN | xclip -selection clipboard
echo $TOKEN
