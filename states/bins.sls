# path stuff for cli tools
Setup bin dir:
  file.directory:
    - name: {{ pillar['home'] }}/bin
    - user: {{ pillar['user'] }}
    - mode: 700

Setup aws dir:
  file.directory:
    - name: {{ pillar['home'] }}/.aws
    - user: {{ pillar['user'] }}
    - mode: 700

Setup munki scratch dir:
  file.directory:
    - user: {{ pillar['user'] }}
    - names:
      - /Users/Shared/munki_repo/catalogs
      - /Users/Shared/munki_repo/icons
      - /Users/Shared/munki_repo/pkgs
      - /Users/Shared/munki_repo/pkgsinfo
      - /Users/Shared/munki_repo/icons
    - makedirs: True

{% if not salt['file.file_exists']("pillar['home']/.zshrc") %}
Stop apple screwy zsh WORDCHARS not splitting on forwardslash:
  file.managed:
    - name: {{ pillar['home'] }}/.zshrc
    - contents:
      - WORDCHARS=''
      - export PATH=$PATH:{{ pillar['home'] }}/bin
      - export GIT_LFS_SKIP_SMUDGE=1
{% endif %}

{% if not salt['file.search']('/private/etc/pam.d/sudo', 'auth       sufficient     pam_tid.so') %}
TouchID for sudo because the internet:
  file.line:
    - name: /private/etc/pam.d/sudo
    - mode: insert
    - location: start
    - content: auth       sufficient     pam_tid.so
{% endif %}

{% if salt['file.file_exists' ]('/Applications/TextMate.app/Contents/MacOS/mate') %}
Symlink TextMate 'mate' cli tool into path:
  file.symlink:
    - name: {{ pillar['home'] }}/bin/mate
    - user: {{ pillar['user'] }}
    - target: /Applications/TextMate.app/Contents/MacOS/mate
{% endif %}

{% if salt['file.file_exists' ]('/Applications/ViDL.app/Contents/Resources/youtube-dl') %}
Symlink TextMate 'mate' cli tool into path:
  file.symlink:
    - name: {{ pillar['home'] }}/bin/youtube-dl
    - user: {{ pillar['user'] }}
    - target: /Applications/ViDL.app/Contents/Resources/youtube-dl
{% endif %}

# TODO:pre-commit, black,jsonschema install/symlink
#      pylint "/"
