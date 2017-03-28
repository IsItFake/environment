#!/usr/bin/env bash

docker-compose stop frontend
docker-compose build frontend
docker-compose up -d frontend

sleep 5
open -a safari http://fakenews.dev
