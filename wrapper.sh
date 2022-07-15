#!/bin/bash
if [[ ! -x /opt/salt/bin/salt-call ]]; then
  echo "Have you installed salt yet? autopkg install salt"
  exit 1
fi
# can you tell I dislike bash https://stackoverflow.com/a/246128
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
if [[ $DIR != $PWD ]]; then
  echo "Please cd into the directory this script is in,"
  echo $DIR
  exit 2
fi
echo "------ comment out test=True from last line to remove no-op mode!  -------"
echo "--(or control-c while it's waiting for auth so it doesn't blow stuff up)--"
# -k to prompt for sudo every time, intentional
sudo -k /opt/salt/bin/salt-call \
  --local\
      --file-root=${PWD}\
        --pillar-root=${PWD}/pillars\
          --log-level=info\
            --module-dirs=${PWD}/_modules\
              --states-dir=${PWD}/_states\
                state.highstate\
                   pillar="{'home': '$HOME', 'user': '$USER'}"
