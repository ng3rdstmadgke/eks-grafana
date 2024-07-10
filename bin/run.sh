#!/bin/bash

set -e

PROJECT_DIR=$(cd $(dirname $0)/..; pwd)
cd $PROJECT_DIR

trap "docker compose -f docker/docker-compose.yml down" EXIT
docker compose -f docker/docker-compose.yml build grafana
docker compose -f docker/docker-compose.yml up --force-recreate