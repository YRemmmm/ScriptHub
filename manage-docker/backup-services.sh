#!/bin/bash

TIME=$(date +%Y%m%d_%H%M)

docker stop $(docker ps -q)

cd /home && tar -zcvf yremmmm-${TIME}.tar.gz yremmmm/

docker start $(docker ps -a -q)

find /home -name "yremmmm-*.tar.gz" -mtime +7 -delete