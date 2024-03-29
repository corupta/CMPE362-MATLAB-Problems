#!/bin/bash

if ! [ -x "$(command -v markdown-pdf)" ]; then
  echo 'Error: markdown-pdf is not installed.'
  echo 'Please install it with npm i -g markdown-pdf';
  echo 'If npm fails, try again using node version 8';
  exit 1
fi

if ! [ -x "$(command -v ots)" ]; then
  echo 'Error: ots (opentimestamps-client) is not installed.'
  exit 1
fi

if ! [ -x "$(command -v zip)" ]; then
  echo 'Error: zip is not installed.'
  exit 1
fi

OUTPUT_FILE="2016400141_CmpE362_HW3"

rm "$OUTPUT_FILE.zip"
rm "$OUTPUT_FILE.zip.ots"
cd Report
markdown-pdf Report.md -o Report.pdf -s md-pdf.css -r "portrait" -m "{\"html\":true,\"breaks\":false}"
mv Report.pdf ../Report.pdf
cd ..

cd src
rm *.m~
cd ..
zip "$OUTPUT_FILE.zip" -r Figures ProvidedFiles CreatedAudio src Report.pdf
ots stamp "$OUTPUT_FILE.zip"
# ots upgrade "$OUTPUT_FILE.zip.ots"
rm Report.pdf
rm -r "$OUTPUT_FILE"
unzip "$OUTPUT_FILE.zip" -d "$OUTPUT_FILE"

echo "Zip $OUTPUT_FILE.zip is created, don't forget to check its contents"
echo "Also, don't forget to push the .zip and .ots to github"
echo "Also don't forget to send the .zip to canvas"
