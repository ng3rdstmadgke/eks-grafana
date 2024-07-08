#!/bin/bash

docker build $BUILD_OPTIONS \
  --rm \
  -f docker/grafana/Dockerfile \
  -t grafana-work/grafana:latest \
  .