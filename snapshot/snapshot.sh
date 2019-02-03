#!/bin/bash

set -e

TIMESTAMP=$(date --iso-8601=seconds)

sudo btrfs subvolume snapshot -r "/" "/snapshots/root/${TIMESTAMP}" > /dev/null 2> /dev/null
echo "Snapshot for 'root' done!"

sudo btrfs subvolume snapshot -r "/home" "/snapshots/home/${TIMESTAMP}" > /dev/null 2> /dev/null
echo "Snapshot for 'home' done!"
