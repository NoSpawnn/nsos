#!/usr/bin/env bash

set -euo pipefail

echo "Enabling udev rules for fan-control"

curl -fLs --create-dirs https://raw.githubusercontent.com/wiiznokes/fan-control/master/res/linux/60-fan-control.rules \
    -o /usr/lib/udev/rules.d/60-fan-control.rules
