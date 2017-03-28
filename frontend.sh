#!/usr/bin/env bash

CURRENT_DIR=$(pwd)

SAFARI=0
LOCAL=0

# Usage
usage()
{
cat << EOF
  Build and start the frontend

  usage $0 options
    -h: this message
    -s: open safari at end
    -l: local development
EOF
}

# Options
while getopts ":lhs:" OPTION; do
  case $OPTION in
    h)
      usage
      exit
      ;;

    s)
      SAFARI=1
      ;;

    l)
      LOCAL=1
      ;;
  esac
done

doBuild()
{
  if [ $LOCAL -eq 1 ]; then
    cd $CURRENT_DIR/frontend

    export PORT=9000
    ./node_modules/nodemon/bin/nodemon.js main.js
  else
    cd $CURRENT_DIR

    docker-compose stop frontend
    docker-compose build frontend
    docker-compose up -d frontend
  fi
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
