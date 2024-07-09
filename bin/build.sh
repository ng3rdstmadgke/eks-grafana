#!/bin/bash

docker build $BUILD_OPTIONS \
  --rm \
  -f docker/grafana/Dockerfile \
  -t eks-grafana/grafana:latest \
  .