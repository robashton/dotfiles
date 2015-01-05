#!/bin/bash

HLS_DIR=/tmp/id3as/hls
CUTOFFSECONDS=60

cd $HLS_DIR
SECOND_OLDEST_FILE=$(ls -lrt | tail -2 | head -1 | awk '{print $9}')

if [[ -z $SECOND_OLDEST_FILE ]]; then
  echo "No files in directory so skipping this"
  exit 0
else
  echo "$SECOND_OLDEST_FILE is the second oldest file";
  CHANGED=$(stat -c %Y $SECOND_OLDEST_FILE)
  NOW=$(date +%s)
  AGE=$(expr $NOW - $CHANGED)

  if [[ $AGE -gt $CUTOFFSECONDS ]]; then
    echo "Stream has hung, restarting encoder"
    $(/home/id3as/current_firmware/bin/arqiva_encoder stop)
    $(/home/id3as/current_firmware/bin/arqiva_encoder start)
  else
    echo "Looking good, skipping this"
    exit 0
  fi
fi
