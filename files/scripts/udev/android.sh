#!/usr/bin/env bash

set -euo pipefail

echo -e "Downloading Android udev rule"
curl -fLs --create-dirs https://raw.githubusercontent.com/M0Rf30/android-udev-rules/refs/heads/main/51-android.rules -o /usr/lib/udev/rules.d/51-android.rules
echo -e "Adding adbusers group to sysusers.d"
echo "g adbusers - -" > /usr/lib/sysusers.d/android-udev.conf
