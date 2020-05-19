#!/bin/bash

# Copyright (c) 2020 yuk7 <yukx00@gmail.com>
# Released under the MIT license
# http://opensource.org/licenses/mit-license.php


if [ -f "/init_wsl2/etc/passwd" ]; then
    PW1_MD5=$(md5sum /init_wsl2/etc/passwd | awk '{ print $1 }')
    PW2_MD5=$(md5sum /etc/passwd | awk '{ print $1 }')
    if [ $PW1_MD5 != $PW2_MD5 ] ; then
        cat /init_wsl2/etc/passwd | sed '{s/:[^:]*/:\/init_wsl2\/init_systemd/6}' > /etc/passwd
        mount --bind /init_wsl2/etc /etc
    fi
fi


SH=$(awk -F":" "\$4 == \"${INIT_WSL_UID}\" {print \$7}" /etc/passwd)

daemonize /usr/bin/unshare --fork --pid --mount-proc /lib/systemd/systemd --system-unit=basic.target

# Wait for systemd daemon
while [[ "${SYSTEMD_PID}" = "" ]]; do
    SYSTEMD_PID=$(pgrep -xo systemd)
    sleep 0.1
done

INIT_WSL_USER=$(id -u -n ${INIT_WSL_UID})

exec nsenter -t ${SYSTEMD_PID} --all /sbin/runuser -s "${SH}" "${INIT_WSL_USER}" -- "${@}"