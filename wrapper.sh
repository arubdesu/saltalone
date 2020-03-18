#!/bin/bash
if [[ ! -x /opt/salt/bin/salt-call ]]; then
  echo "Have you installed salt yet? autopkg install salt"
  exit 1
fi
echo "------ comment out test=True from last line to remove no-op mode!  -------"
echo "--(or control-c while it's waiting for auth so it doesn't blow stuff up)--"
sudo -k /opt/salt/bin/salt-call \
  --local\
      --file-root=${PWD}\
        --pillar-root=${PWD}/pillars\
          --log-level=info\
            --module-dirs=${PWD}/_modules\
              --states-dir=${PWD}/_states\
                state.highstate\
                   pillar="{'home': '$HOME', 'user': '$USER'}"\
                     test=True
