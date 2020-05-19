#!/usr/.bin/bash

# Copyright (c) 2020 yuk7 <yukx00@gmail.com>
# Released under the MIT license
# http://opensource.org/licenses/mit-license.php


/usr/.bin/cp -nd /usr/bin/* /usr/.bin/ 2>/dev/null
/usr/.bin/mount --bind /usr/.bin /usr/bin
