#!/bin/bash

echo "Running generate_WORLD.sh..."

cd svgs
./generate_WORLD.sh
cd ..

echo
echo
echo "Packaging all the cursors"
echo
echo

colors="blue yellow brown grey green violet red purple navy sea_blue emerald hot_orange white"

mkdir -p temp
cd temp

for color in $colors; do

  mkdir -p $color
  cd $color
    
  cat > index.theme << EOF
[Icon Theme]
Name = Oxygen $color
Comment = The Oxygen mouse theme. Oxygenize your desktop!
EOF

  mkdir cursors
  cp ../../cursors/$color/* cursors/

  cd ..
  tar -cf oxygen-cursors-$color.tar $color

done

cd ..
cp temp/*.tar.bz2 .
rm -rf temp/
