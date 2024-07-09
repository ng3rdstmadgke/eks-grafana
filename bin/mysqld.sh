#!/bin/bash

set -exu

# docker build
docker build --rm -f docker/mysql/Dockerfile -t "eks-grafana/mysql:latest" .

# docker run
docker rm -f eks-grafana-mysql
docker run -d --rm \
  --name $LOCAL_MYSQL_HOST \
  -e "MYSQL_USER=$LOCAL_MYSQL_USER" \
  -e "MYSQL_PASSWORD=$LOCAL_MYSQL_PASSWORD" \
  -e "MYSQL_DATABASE=$LOCAL_MYSQL_DATABASE" \
  -e "MYSQL_ROOT_PASSWORD=$LOCAL_MYSQL_ROOT_PASSWORD" \
  --network br-eks-grafana \
  eks-grafana/mysql:latest

docker run --rm \
  --name eks-grafana-mysql-check \
  -e "MYSQL_HOST=$LOCAL_MYSQL_HOST" \
  -e "MYSQL_USER=$LOCAL_MYSQL_USER" \
  -e "MYSQL_PASSWORD=$LOCAL_MYSQL_PASSWORD" \
  -e "MYSQL_DATABASE=$LOCAL_MYSQL_DATABASE" \
  -e "MYSQL_ROOT_PASSWORD=$LOCAL_MYSQL_ROOT_PASSWORD" \
  --network br-eks-grafana \
  eks-grafana/mysql:latest \
  /usr/local/bin/check-mysql-boot.sh