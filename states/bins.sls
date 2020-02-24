# path stuff for cli tools
Setup bin dir:
  file.directory:
    - name: {{ pillar['home'] }}/Documents/bin
    - user: {{ pillar['user'] }}

Setup aws dir:
  file.directory:
    - name: {{ pillar['home'] }}/.aws
    - user: {{ pillar['user'] }}
    - dir_mode: 700

Setup munki scratch dir:
  file.directory:
    - user: {{ pillar['user'] }}
    - names:
      - /Users/Shared/repo
      - /Users/Shared/repo/catalogs
      - /Users/Shared/repo/icons
      - /Users/Shared/repo/pkgs
      - /Users/Shared/repo/pkgsinfo
      - /Users/Shared/repo/icons

Setup bash_profile, including symlink to python2.7 tools installed by pip:
  file.append:
    - name: {{ pillar['home'] }}/.bash_profile
    - text:
      - export PATH="$PATH:{{ pillar['home'] }}/Library/Python/2.7/bin"
      - export LC_ALL='en_US.UTF-8'
      - export LANG='en_US.UTF-8'
# eventually https://cloud.google.com/sdk/docs/downloads-interactive#silent