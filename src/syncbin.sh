#!/usr/.bin/bash

# Copyright (c) 2020 yuk7 <yukx00@gmail.com>
# Released under the MIT license
# http://opensource.org/licenses/mit-license.php

export PATH=/usr/.bin:$PATH

# Don't kill this
while true; do
    ls /usr/.bin/ | xargs -I{} ln -s "/init_wsl2/init_systemd" "/usr/bin/{}" 2>/dev/null
    sleep 1;
done