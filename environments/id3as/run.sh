#!/bin/bash
MOUNT=`pwd`
super docker.io stop id3as || true
super docker.io run --expose=8081 --privileged -v $MOUNT:/host -a stdin -a stdout -i -t id3as $@
