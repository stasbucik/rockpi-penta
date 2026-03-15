#!/usr/bin/env bash

docker build \
  --build-arg USER_ID=$(id -u) \
  --build-arg GROUP_ID=$(id -g) \
  -t deb-builder .

docker run --rm -v $(pwd):/workspace deb-builder dpkg-deb --root-owner-group --build -Z gzip rockpi-penta
