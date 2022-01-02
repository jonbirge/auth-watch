#!/bin/bash

docker build --tag cronjob:testing .

rm -f test-db/auth.log
rm -f test-db/heartbeat
rm -f test-db/logdb.mat

docker run -d \
  --mount type=bind,source="$(pwd)"/test-db,target=/db \
  --mount type=bind,source="$(pwd)"/test-log,target=/log \
  --mount type=bind,source="$(pwd)"/test-www,target=/www \
  cronjob:testing
