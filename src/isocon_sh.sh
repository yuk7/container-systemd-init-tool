#!/bin/bash

# Copyright (c) 2020 yuk7 <yukx00@gmail.com>
# Released under the MIT license
# http://opensource.org/licenses/mit-license.php

# Wait for systemd daemon
while [[ "${SYSTEMD_PID}" = '' ]]; do
    SYSTEMD_PID=$(pgrep -xo systemd)
    sleep 0.01
done

INIT_WSL_UID=$1
INIT_WSL_USER=$(id -u -n ${INIT_WSL_UID})

EXEC_BIN=$(echo $2 | sed 's#^-#/bin/#g')
exec nsenter -t ${SYSTEMD_PID} --all --wd="${PWD}" /sbin/runuser -u "${INIT_WSL_USER}" --  "$EXEC_BIN" "${@:3}"