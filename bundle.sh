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

rm 2016400141_CMPE362_HW1.zip
rm 2016400141_CMPE362_HW1.zip.ots
cd Report
markdown-pdf Report.md -o Report.pdf -s md-pdf.css -r "portrait"
mv Report.pdf ../Report.pdf
cd ..

zip 2016400141_CMPE362_HW1.zip -r Figures ProvidedFiles src Report.pdf
ots stamp 2016400141_CMPE362_HW1.zip
# ots upgrade 2016400141_CMPE362_HW1.zip.ots
rm Report.pdf
rm -r 2016400141_CMPE362_HW1
unzip 2016400141_CMPE362_HW1.zip -d 2016400141_CMPE362_HW1

echo "Zip 2016400141_CMPE362_HW1.zip is created, don't forget to check its contents"
echo "Also, don't forget to push the .zip and .ots to github"
echo "Also don't forget to send the .zip to canvas"
