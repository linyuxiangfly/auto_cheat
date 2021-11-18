#!/bin/bash
#free -m > /tmp/freee
#cat /tmp/freee
mkdir /tmp/$3
mount -t ramfs -o size=$1K ramfs /tmp/$3
#mount -t tmpfs -o size=$1M tmpfs /tmp/$3
dd if=/dev/zero of=/tmp/$3/block bs=1024 count=$1
#free -m > /tmp/freee
#cat /tmp/freee
sleep $2
rm -rf /tmp/$3/block
umount /tmp/$3
rmdir /tmp/$3
