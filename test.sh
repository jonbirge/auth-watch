#!/bin/bash

docker build --tag jonbirge/authwatch:testing .

rm -f test-db/*
rm -f test-www/*

docker run -d \
  --mount type=bind,source="$(pwd)"/test-db,target=/db \
  --mount type=bind,source="$(pwd)"/test-log,target=/log \
  --mount type=bind,source="$(pwd)"/test-www,target=/www \
  jonbirge/authwatch:testing
