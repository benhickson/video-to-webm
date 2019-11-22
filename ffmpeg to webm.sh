#!/bin/bash

# uncomment this to enable debugging mode:
# set -x

# request an input file from the user
read -p "Drag an input video file here: " inputFile

# request the target bitrate from the user, add "M" to it
read -p "Enter a target bitrate, in terms of Mbit/s: " targetBitrate
targetBitrate="$targetBitrate""M"

# change the extension to .webm for the output file
outputFile="$(echo "$inputFile" | sed -e 's/\.[^.]*$//').webm"

# set a destination for a temp file
# currently in the user's home folder - should probably put this somewhere more hidden
tempFile=~/$(date +"%s")

# convert the video
ffmpeg -i "$inputFile" -c:v libvpx-vp9 -b:v "$targetBitrate" -pass 1 -an -f webm "$tempFile" && ffmpeg -i "$inputFile" -c:v libvpx-vp9 -b:v $targetBitrate -pass 2 -an "$outputFile"

# delete the temp file
rm $tempFile
