#!/bin/bash

docker build --tag cronjob:testing .

docker run -d --mount type=bind,source="$(pwd)"/db,target=/db \
  cronjob:testing
