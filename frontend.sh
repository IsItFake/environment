#!/usr/bin/env bash

SAFARI=0

# Usage
usage()
{
cat << EOF
  Build and start the frontend

  usage $0 options
    -h: this message
    -s: open safari at end
EOF
}

# Options
while getopts ":hs:" OPTION; do
  case $OPTION in
    h)
      usage
      exit
      ;;

    s)
      SAFARI=1
      ;;
  esac
done

doBuild()
{
  docker-compose stop frontend
  docker-compose build frontend
  docker-compose up -d frontend
}

doSafari()
{
  sleep 5
  open -a safari http://fakenews.dev
}

doFrontEnd()
{
  doBuild

  if [ $SAFARI -eq 1 ]; then
    doSafari
  fi
}

doFrontEnd
