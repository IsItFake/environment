#!/usr/bin/env bash

PULL=0
SAFARI=0

# Usage
usage()
{
cat << EOF
  Build and start environment

  usage $0 options
    -h: this message
    -f: pull repos and build
    -s: do safari at the end
EOF
}

# Options
while getopts ":hf:" OPTION; do
  case $OPTION in
    h)
      usage
      exit
      ;;

    f)
      PULL=1
      ;;
  esac
done

doFull()
{
  if [ $PULL -eq 1 ]; then
    doPull
  fi

  docker-compose up -d
  runScripts
  docker-compose logs -f
}

doPull()
{
  git clone git@github.com:isitfake/api.git api
  git clone git@github.com:isitfake/frontend.git frontend
}

runScripts()
{
  if [ $SAFARI -eq 1 ]; then
    ./frontend.sh -s
    ./api.sh -s
  else
    ./frontend.sh
    ./api.sh
  fi
}

doFull
