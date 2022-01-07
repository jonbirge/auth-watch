#!/bin/bash

docker build --tag jonbirge/authwatch:latest .

docker push jonbirge/authwatch:latest
