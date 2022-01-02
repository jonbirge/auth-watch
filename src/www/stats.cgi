#!/bin/bash
cd ..
echo -e "Content-type: text/html\n\n"
echo "Requested on: "
date
echo "<br>"
octave genplots.m &> www/stats.cgi.log
echo "Generated: "
date
echo "<br>"
cat www/stats.html
