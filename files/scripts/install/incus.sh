#!/usr/bin/env bash

# At the time of writing, the incus-agent binary in the DNF repos is broken due to dynamic linking,
# so install it manually for now
# - https://bugzilla.redhat.com/show_bug.cgi?id=2389081

set -euo pipefail

TEMP=$(mktemp -d)

curl -fLs https://github.com/lxc/incus/releases/latest/download/bin.linux.incus.x86_64 -o $TEMP/incus
mv $TEMP/incus /usr/bin/incus
chmod 0755 /usr/bin/incus

curl -fLs https://github.com/lxc/incus/releases/latest/download/bin.linux.incus-agent.x86_64 -o $TEMP/incus-agent
mv $TEMP/incus-agent /usr/bin/incus-agent
chmod 0755 /usr/bin/incus-agent

rm -r $TEMP
