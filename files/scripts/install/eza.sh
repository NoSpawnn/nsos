#!/usr/bin/env bash

# As of Fedora 42, eza isn't in DNF repos, so install it manually
# `ls` gets aliased to `eza`, see files/system/etc/profile.d/zz-aliases.sh

set -euo pipefail

TEMP=$(mktemp -d)

curl -fLs https://github.com/eza-community/eza/releases/latest/download/eza_x86_64-unknown-linux-gnu.tar.gz -o $TEMP/eza.tar.gz
tar xvf $TEMP/eza.tar.gz --directory $TEMP
mv $TEMP/eza /usr/bin/eza

rm -r $TEMP
