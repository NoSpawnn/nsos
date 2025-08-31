#!/usr/bin/env bash

set -euo pipefail

TEMP=$(mktemp -d)

echo "Downloading ublue packages config"
curl -fLs --create-dirs https://github.com/ublue-os/packages/archive/refs/heads/main.zip -o $TEMP/packages.zip
unzip -q $TEMP/packages.zip -d $TEMP/

echo "Copying ublue udev rules"
cp $TEMP/packages-main/packages/ublue-os-udev-rules/src/udev-rules.d/*.rules /usr/lib/udev/rules.d/

echo "Enabling systemd timers for flatpak updaters"
systemctl --system enable flatpak-system-update.timer
systemctl --global enable flatpak-user-update.timer

echo "Copying ublue LUKS scripts"
cp $TEMP/packages-main/packages/ublue-os-luks/src/luks-enable-tpm2-autounlock /usr/libexec/luks-enable-tpm2-autounlock
cp $TEMP/packages-main/packages/ublue-os-luks/src/luks-disable-tpm2-autounlock /usr/libexec/luks-disable-tpm2-autounlock

rm -r $TEMP
