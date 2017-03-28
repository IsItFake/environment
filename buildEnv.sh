#!/usr/bin/env bash

PULL=0

# Usage
usage()
{
cat << EOF
  Build and start environment

  usage $0 options
    -h: this message
    -f: pull repos and build
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
  git clone git@github.com:Keloran/fakenews_api.git api
  git clone git@github.com:Keloran/fakenews_frontend.git frontend
}

runScripts()
{
  ./frontend.sh
  ./api.sh
}

doFull
