#!/bin/bash

cd ..


if [ $1 = "up" ]; then
    echo "Creating docker networks"
    docker network create isebackend_default
    docker network create isefrontend_default
    docker network create isemonitoring_default
    docker network create iseproxy_default
fi

cd ise_2019_dev_infra
cd monitoring
docker-compose -p isemonitoring "$@"

cd ..
cd ..
cd ise_2019_backend
if [ ! -d "node_modules" ] ; then
    npm install --silent
fi
docker-compose -p isebackend "$@"

cd ..
cd ise_2019_frontend
if [ ! -d "node_modules" ] ; then
    npm install --silent
fi
docker-compose -p isefrontend "$@"

cd ..
cd ise_2019_dev_infra
cd proxy
docker-compose -p iseproxy "$@"

if [ $1 = "down" ]; then
    echo "Cleaning up"
    docker network prune -f
    docker container prune -f
fi
