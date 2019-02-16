#!/bin/bash

readonly USER="usezmap@gmail.com"

function usage() {
    echo "usage: bank <bank> <first> <second>"
    echo "  <bank>      name of the bank"
    echo "  <first>     first code"
    echo "  <second>    second code"
}

function errecho() {
    >&2 echo "$@"
}

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

BANK=$1
FIRST=$2
SECOND=$3

if [[ $# -ne 3 ]]; then
    usage
    exit 1
fi

readonly BANK_FILE="$DIR/banks/$BANK.gpg"

if ! [[ -f $BANK_FILE  ]]; then
    errecho "No such bank"
    exit 1
fi

NUMRE='^[0-9]+$'
if ! [[ $FIRST =~ $NUMRE ]]; then
    usage
    exit 1
fi

if ! [[ $SECOND =~ $NUMRE ]]; then
    usage
    exit 1
fi

readonly FIRSTIND=$(echo "$FIRST * 2 - 1" | bc)
readonly SECONDIND=$(echo "$SECOND * 2" | bc)

BANKCARD=$(cat $BANK_FILE | gpg --decrypt --quiet 2>/dev/null)

FIRSTCODE=$(echo "$BANKCARD" | cut -d" " -f$FIRSTIND)
SECONDCODE=$(echo "$BANKCARD" | cut -d" " -f$SECONDIND)

echo "$FIRSTCODE $SECONDCODE"
