#!/usr/.bin/bash

# Copyright (c) 2020 yuk7 <yukx00@gmail.com>
# Released under the MIT license
# http://opensource.org/licenses/mit-license.php


# Mount only for container
/usr/.bin/mount --make-private --bind /init_wsl2/passwd /etc/passwd
/usr/.bin/mount --make-private --bind /usr/.bin /usr/bin


daemonize /usr/bin/unshare --fork --pid --mount-proc /lib/systemd/systemd --system-unit=basic.target

# Don't kill this
while true; do
    sleep 10000;
done