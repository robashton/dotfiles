#!/bin/bash
MOUNT=`pwd`
sudo docker stop id3as || true
sudo docker run --expose=8081 --privileged -v $MOUNT:/host -a stdin -a stdout -i -t id3as $@
