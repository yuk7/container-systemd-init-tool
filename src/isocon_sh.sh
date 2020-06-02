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
INIT_WSL_GID=$(awk -F":" "\$4 == \"${INIT_WSL_UID}\" {print \$4}" /etc/passwd)

EXEC_BIN=$(echo $2 | sed 's#^-#/bin/#g')
exec nsenter -t ${SYSTEMD_PID} -S ${INIT_WSL_UID} -G ${INIT_WSL_GID} --all --wd="${PWD}" "$EXEC_BIN" "${@:3}"