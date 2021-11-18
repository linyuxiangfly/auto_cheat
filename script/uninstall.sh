#!/bin/bash

systemctl stop cheat.service
systemctl disable cheat.service

`dirname $0`/unconsume_mem.sh cheat_memory &
