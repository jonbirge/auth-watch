#!/bin/bash

docker build --tag jonbirge/authwatch:dev .

docker push jonbirge/authwatch:dev
