#!/bin/bash
MOUNT=`pwd`
super docker stop id3as || true
super docker run --expose=9200 --expose=80 --expose=8000 --expose=5556 --expose=5555 --privileged -v $MOUNT:/host -a stdin -a stdout -i -t id3as $@
