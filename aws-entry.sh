#!/usr/bin/env bash

## This script is called by AWS as the instance becomes live, its responsible for kicking
# off docker

sudo docker rm ft-build ; sudo docker run --name ft-build freudek90/ft-updatebuild:1.4 sh -c 'export LC_ALL=C.UTF-8 && export LANG=C.UTF-8 && cd /root/ft-update && git pull && ./build.sh'