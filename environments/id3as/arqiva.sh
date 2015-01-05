#!/bin/bash
MOUNT=`pwd`
super docker stop id3as || true
super docker rm id3as || true
super docker run --name=id3as --expose=8080 --privileged -v $MOUNT:/host -i -t id3as $@
