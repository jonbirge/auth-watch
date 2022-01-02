#!/bin/bash

echo "running db update..." >&2
cd /src
/usr/bin/octave updatedb.m >&2
