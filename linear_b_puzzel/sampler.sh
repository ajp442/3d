#!/bin/bash

rm black.png black_flopped.png white.png white_flopped.png

if [ "clear" != "$1" ]; then
    inkscape -z -e "black.png" -w 1000 -h 1000 "$1"
    convert -flatten "black.png" "black.png"
    convert "black.png" -crop 500x500+250+250 "black.png"
    convert "black.png" -resize 50x50 "black.png"
    convert -negate "black.png" "white.png"
    convert -flop "black.png" "black_flopped.png"
    convert -flop "white.png" "white_flopped.png"
fi
