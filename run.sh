#/bin/bash

set +e

ENV=$1

if [ -z "$ENV" ]; then
  echo "Usage: ./run.sh 'env'"
  exit 1
fi;


function main {
  . _cfg/boot/$ENV.sh
}

main
exit
