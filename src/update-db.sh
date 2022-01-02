#!/bin/bash

echo "running db update..." >&2
cd /src
/usr/bin/octave /src/updatedb.m >&2
