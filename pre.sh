#!/bin/bash
set -x
AUTOPKG_LATEST=$(curl https://api.github.com/repos/autopkg/autopkg/releases | python -c 'import json,sys;obj=json.load(sys.stdin);print obj[0]["assets"][0]["browser_download_url"]')
curl -L "${AUTOPKG_LATEST}" -o /tmp/apkg.pkg
sudo installer -pkg /tmp/apkg.pkg -target /
autopkg repo-add mosen-recipes && autopkg run -vvv --key PYVERSION=3 salt.install
sudo echo "master_type: disable" >> /etc/salt/minion
sudo echo "log_level: debug" >> /etc/salt/minion
sudo echo "enable_fqdns_grains: False" >> /etc/salt/minion
