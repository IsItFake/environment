#!/usr/bin/env bash

CURRENT_DIR=$(pwd)

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
  docker-compose stop api

  doMaven

  cd $CURRENT_DIR
  docker-compose up -d api
}

doMaven()
{
  cd $CURRENT_DIR/api
  mvn clean install package
}

doSafari()
{
  sleep 20
  open -a safari http://api.fakenews.dev:8080
}

doAPI()
{
  doBuild

  if [ $SAFARI -eq 1 ]; then
    doSafari
  fi
}

doAPI
