#!/bin/bash

for f in *.svg; do
    p="${f%.svg}.png"
    inkscape -z -e "$p" -w 1000 -h 1000 "$f"
    convert -flatten "$p" "$p"
    convert "$p" -crop 500x500+250+250 "$p"
done
