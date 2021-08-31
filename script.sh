#!/usr/.bin/bash

# Copyright (c) 2020 yuk7 <yukx00@gmail.com>
# Released under the MIT license
# http://opensource.org/licenses/mit-license.php


export PATH=/usr/.bin:$PATH

# WSL2 check
FSTYPE_LIST=$(cat /proc/self/mounts | awk '{print $3}')
if [[ $FSTYPE_LIST == *lxfs* || $FSTYPE_LIST == *wslfs* ]] ; then
    echo ----- ERROR -----  >&2
    echo This distribution only works with WSL2. >&2
    echo This is running in WSL1 mode now.  >&2
    echo Please use WSL2 mode.  >&2
    echo >&2
    read -t 5 -n 1 -s -r -p "Press any key to continue..."
    exit 1
fi

# avoid first run
if [[ -z "$(df | grep 'C:')" ]] ; then
    exec $(echo ${@} | sed 's#/sbin/#/usr/.bin/#g' | sed 's#^/usr/bin/#/usr/.bin/#g')
fi 

# debug
if [[ "${@}" =~ "_debug" ]] ; then
    exec bash
fi 

CONTAINER_PID=$(pgrep -xo systemd)

# if the container daemon isn't running, run it.
if [ "$CONTAINER_PID" = '' ] ; then
    daemonize /usr/.bin/unshare --fork --pid --mount-proc /boot/init_wsl2/wsl2_isocond.sh
    daemonize /boot/init_wsl2/syncbin.sh
fi

while [[ "${CONTAINER_PID}" = '' ]]; do
    CONTAINER_PID=$(pgrep -xo systemd)
    sleep 0.01
done

exec nsenter -t ${CONTAINER_PID} -m -p --wd="${PWD}" /usr/.bin/bash -- /boot/init_wsl2/isocon_sh.sh ${INIT_WSL_UID} "${@}"
