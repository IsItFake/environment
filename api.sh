#!/usr/bin/env bash

CURRENT_DIR=$(pwd)

docker-compose stop api

cd $CURRENT_DIR/api
mvn clean install package

cd $CURRENT_DIR
docker-compose up -d api
