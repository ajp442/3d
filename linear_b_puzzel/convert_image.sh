#!/bin/bash

for f in *.svg; do
    p="${f%.svg}.png"
    inkscape -z -e "$p" -w 1000 -h 1000 "$f"
    convert -flatten "$p" "$p"
    convert "$p" -crop 500x500+250+250 "$p"
    convert "$p" -resize 50x50 "$p"
done

# Possibly rename these images to something shorter.
rename 's/(Linear_B_Syllable_)(.*$)/$2/' *.png
