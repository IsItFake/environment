#!/usr/bin/env bash

CURRENT_DIR=$(pwd)

docker-compose stop api

cd $CURRENT_DIR/api
mvn clean install package

cd $CURRENT_DIR
docker-compose up -d api

sleep 20
open -a safari http://api.fakenews.dev:8080
