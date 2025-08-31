#!/usr/bin/env bash

# As of Fedora 42, eza isn't in DNF repos, so install it manually

set -euo pipefail

TMP=$(mktemp -d)

cd $TMP
wget https://github.com/eza-community/eza/releases/latest/download/eza_x86_64-unknown-linux-gnu.tar.gz -O eza.tar.gz
tar xvf eza.tar.gz
mv eza /usr/bin/eza

rm -r $TMP
