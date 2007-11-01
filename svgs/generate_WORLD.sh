#!/bin/bash

colors="blue yellow brown grey green violet red purple navy sea_blue emerald hot_orange white"

for color in $colors; do

mkdir -p $color;

done

./change-colors.pl -a
./generate_pngs.sh
./generate_cursors.sh 
