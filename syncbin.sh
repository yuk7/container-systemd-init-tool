#!/usr/.bin/bash

# Copyright (c) 2020 yuk7 <yukx00@gmail.com>
# Released under the MIT license
# http://opensource.org/licenses/mit-license.php

export PATH=/usr/.bin:$PATH

# Don't kill this
while true; do
    for f in `ls /usr/bin/`; do
        if [ ! -e /usr/.bin/${f} ]; then
            LINKTO=$(readlink /usr/bin/${f})
            if [ ! `echo ${LINKTO}|grep init_systemd` ]; then
                cp -nd "/usr/bin/${f}" "/usr/.bin/" 2>/dev/null
            fi
        fi
    done

    for f in `ls /usr/.bin/`; do
        if [ ! -e /usr/bin/${f} ]; then
            ln -s "/boot/init_wsl2/init_systemd" "/usr/bin/${f}" 2>/dev/null
        fi
    done
    
    sleep 7;
done