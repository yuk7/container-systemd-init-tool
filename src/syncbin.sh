#!/usr/.bin/bash

# Copyright (c) 2020 yuk7 <yukx00@gmail.com>
# Released under the MIT license
# http://opensource.org/licenses/mit-license.php

export PATH=/usr/.bin:$PATH

# Don't kill this
while true; do
    for f in `ls /usr/bin/`; do
        LINKTO=$(readlink /usr/bin/${f})
        if [ ! `echo ${LINKTO}|grep init_systemd` ]; then
            cp -nd "/usr/bin/${f}" "/usr/.bin/" 2>/dev/null
        fi
    done
    ls /usr/.bin/ | xargs -I{} ln -s "/boot/init_wsl2/init_systemd" "/usr/bin/{}" 2>/dev/null
    
    sleep 7;
done