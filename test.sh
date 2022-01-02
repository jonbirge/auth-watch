#!/bin/bash

docker build --tag cronjob:testing .

rm -f test-db/auth.log
rm -f test-db/heartbeat
docker run -d \
  --mount type=bind,source="$(pwd)"/test-db,target=/db \
  --mount type=bind,source="$(pwd)"/test-log,target=/log \
  cronjob:testing
