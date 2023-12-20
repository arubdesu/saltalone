#!/bin/bash
# gotta also have git, via xcodeclitools which'll give us a python3 as well
# https://gist.github.com/arubdesu/c180ebd0b0aefadd23cf88197343d7fc
set -x
AUTOPKG_LATEST=$(curl https://api.github.com/repos/autopkg/autopkg/releases | /usr/bin/python3 -c 'import json,sys;obj=json.load(sys.stdin);print(obj[0]["assets"][0]["browser_download_url"])')
curl -L "${AUTOPKG_LATEST}" -o /tmp/apkg.pkg
sudo installer -pkg /tmp/apkg.pkg -target /
## as of late 2023 there IS an ARM salt, but autopkg can't find anything py3 'latest'
## https://repo.saltproject.io/salt/py3/macos/latest/salt-3006.5-py3-arm64.pkg 
# autopkg repo-add mosen-recipes && autopkg run -vvv --key PYVERSION=3 salt.install
# sudo echo "master_type: disable" >> /etc/salt/minion
# sudo echo "log_level: debug" >> /etc/salt/minion
# sudo echo "enable_fqdns_grains: False" >> /etc/salt/minion
# sudo echo "multiprocessing: True" >> /etc/salt/minion
