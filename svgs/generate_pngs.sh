#!/bin/bash

colors="blue yellow brown grey green violet red purple navy sea_blue emerald hot_orange white"
oldDir=$(pwd)
SIZE="24"

for color in $colors; do

echo "Generating PNGs for the color: $color"

mkdir -p ../pngs
mkdir -p ../pngs/$color;
cp $color/*.svg ../pngs/$color/
cd ../pngs/$color/

#cleanup from previous pngs
rm *.png

for icon in $(ls *.svg); do
  if [ "$icon" != "half-busy.svg" ];
 then 
	inkscape --without-gui --export-png=$( echo $icon | sed s/.svg// ).png --export-dpi=72 --export-background-opacity=0 --export-width=$SIZE --export-height=$SIZE $icon 2> /dev/null;
  else
        inkscape --without-gui --export-png=$( echo $icon | sed s/.svg// ).png --export-background-opacity=0 --export-width=32 --export-height=32 $icon 2> /dev/null;
  fi
done

rm *.svg
cd $oldDir
done




