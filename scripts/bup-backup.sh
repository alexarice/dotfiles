#!/bin/sh

export BUP_DIR=/run/media/alex/EXT_HDR/backups

if [ ! -d $BUP_DIR ]; then
    echo Cannot find backup drive
    exit
fi
if [ "$EUID" -ne 0 ]; then
    echo Run as root
    exit
fi
echo backing up root
bup index --exclude /var/run/media --exclude /var/cache --exclude /var/tmp --exclude /sys --exclude /proc --exclude /tmp --exclude /lost+found --exclude /dev --exclude /run /
bup save -n backup_root /

echo finished
