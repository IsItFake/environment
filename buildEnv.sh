#!/usr/bin/env bash

git clone git@github.com:Keloran/fakenews_api.git api
git clone git@github.com:Keloran/fakenews_frontend.git frontend

docker-compose up -d
./frontend.sh

open -a safari http://localhost

docker-compose logs -f
