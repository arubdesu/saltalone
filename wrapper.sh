#!/bin/bash
sudo salt-call \
  --local\
      --file-root=${PWD}\
        --pillar-root=${PWD}/pillars\
          --log-level=info\
               state.highstate\
                 pillar="{'home': '$HOME', 'user': '$USER'}"\
                   test=True
# --config-dir=${PWD} - I think I'd only need that if I was e.g. saying `file_client: local` in a minion file 
# instead of on the CLI
