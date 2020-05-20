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

SH=$(awk -F":" "\$4 == \"${INIT_WSL_UID}\" {print \$7}" /etc/passwd)
INIT_WSL_GID=$(awk -F":" "\$4 == \"${INIT_WSL_UID}\" {print \$4}" /etc/passwd)

exec nsenter -t ${SYSTEMD_PID} -S ${INIT_WSL_UID} -G ${INIT_WSL_GID} --all "${SH}" "${@:2}"