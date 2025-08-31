#!/usr/bin/env bash

# https://codeberg.org/fabiscafe/game-devices-udev

set -euo pipefail

TEMP=$(mktemp -d)

echo -e "Downloading game-device-udev zip"
curl -fLs https://codeberg.org/fabiscafe/game-devices-udev/archive/main.zip -o $TEMP/main.zip
echo -e "Unzipping"
unzip -q $TEMP/main.zip -d $TEMP/rules/
cp $TEMP/rules/game-devices-udev/*.rules /usr/lib/udev/rules.d/

rm -r $TEMP
