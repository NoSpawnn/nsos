#!/usr/bin/env bash

set -euo pipefail

echo "compress=\"zstd\"" > /usr/lib/dracut/dracut.conf.d/10-compression.conf
