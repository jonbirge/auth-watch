#!/bin/bash

echo "running plot generation..." >&2

# copy in static files as neccesary
if [ -f /www/index.shtml ]; then
    echo "running plot generation..." >&2
else 
    echo "copying in static files and generating plots..." >&2
    cp /src/www/* /www
fi

# generate updated plots
cd /src
/usr/bin/octave genplots.m >&2
