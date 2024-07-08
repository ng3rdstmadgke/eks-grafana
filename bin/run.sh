#!/bin/bash

set -e

#docker build $BUILD_OPTIONS \
#  --rm \
#  -f docker/grafana/Dockerfile \
#  -t grafana-work/grafana:latest \
#  .
#
#docker run -ti --rm \
#  -p 3001:3001 \
#  --name grafana-work \
#  -e GF_SECURITY_ADMIN_USER=admin \
#  -e GF_SECURITY_ADMIN_PASSWORD=tapioka! \
#  grafana-work/grafana:latest

PROJECT_DIR=$(cd $(dirname $0)/..; pwd)
cd $PROJECT_DIR

trap "docker compose -f docker-compose.yml down" EXIT
docker compose build grafana
docker compose -f docker-compose.yml up --force-recreate