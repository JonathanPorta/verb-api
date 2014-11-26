#!/bin/bash

set -e

echo "Downloading gemnasium cli..."
mkdir -p ~/gemnasium
curl -SLO "https://github.com/gemnasium/toolbelt/releases/download/0.2.5/gemnasium_0.2.5_linux_amd64.tar.gz"
tar -xzf "gemnasium_0.2.5_linux_amd64.tar.gz" -C ~/gemnasium --strip-components=1

~/gemnasium/gemnasium --token $GEMNASIUM_TOKEN autoupdate
