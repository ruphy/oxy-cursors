#!/bin/bash

lighterColor="#d8e8c2"
mediumColor="#00892c"
darkerColor="#006e29"

for icon in $(ls *.svg); do

cp $icon $( echo $icon | sed s/.svg// )-old.svg

perl -pi -e "s/#eeeeec;/$lighterColor;/g" $icon
perl -pi -e "s/fill:#555753;fill-rule:evenodd;stroke:#2e3436;/fill:$mediumColor;fill-rule:evenodd;stroke:$darkerColor;/g" $icon
# perl -pi -e "s/style=\"stop-color:#eeeeec;stop-opacity:1;\"/style=\"stop-color:$lighterColor;stop-opacity:1;\""
done
