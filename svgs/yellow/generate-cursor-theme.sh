#!/bin/bash

SIZE=24

#Prepare the layout
# mkdir oxygen
# mkdir oxygen/cursors
# cat > oxygen/index.theme << EOF
# [Icon Theme]
# Name = Oxygen
# Comment = The Oxygen mouse theme. Oxygenize your desktop!
# EOF
# 
# #SVG -> PNG
# mkdir oxygen/tmp-sources
# cd oxygen/tmp-sources

for icon in $(ls *.svg); do
inkscape --without-gui --export-png=$( echo $icon | sed s/.svg// ).png --export-dpi=72 --export-background-opacity=0 --export-width=$SIZE --export-height=$SIZE $icon > /dev/null
done

#inkscape --without-gui --export-png=watch.png --export-background-opacity=0 --export-width=32 --export-height=32 ../../svgs/watch.svg > /dev/null
#inkscape --without-gui --export-png=watch1.png --export-background-opacity=0 --export-width=32 --export-height=32 ../../svgs/watch1.svg > /dev/null



#PNG+config file = cursor file

