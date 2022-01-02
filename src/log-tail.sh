#!/bin/bash

# Pull in latest log data
echo "pulling log data..." >&2
tail -n 512 /log/auth.log > /db/auth.log
