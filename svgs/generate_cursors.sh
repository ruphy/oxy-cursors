#!/bin/bash

colors="blue yellow brown grey green violet red purple navy sea_blue emerald hot_orange white"
# colors="green"
oldDir=$(pwd)
# SIZE="24"

# mkdir -p pngs

for color in $colors; do

echo "Generating cursors for the color: $color"

mkdir -p ../cursors/$color;
cp ../pngs/$color/*.png ../cursors/$color/
cp ../configs/*.in ../cursors/$color/
cd ../cursors/$color/

for icon in $(ls *.in); do
xcursorgen $icon $( echo $icon | sed s/.in// )
# inkscape --without-gui --export-png=$( echo $icon | sed s/.svg// ).png --export-dpi=72 --export-background-opacity=0 --export-width=$SIZE --export-height=$SIZE $icon 2> /dev/null
done

rm *.png
rm *.in
cd $oldDir
done
 
