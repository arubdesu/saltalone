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

{% if not salt['file.search']('/private/etc/pam.d/sudo', 'auth       sufficient     pam_tid.so') %}
TouchID for sudo because the internet:
  file.line:
    - name: /private/etc/pam.d/sudo
    - mode: insert
    - location: start
    - content: auth       sufficient     pam_tid.so
{% endif %}

{% if not salt['file.file_exists']("pillar['home']/.zshrc") %}
Stop apple screwy zsh WORDCHARS not splitting on forwardslash:
  file.managed:
    - name: {{ pillar['home'] }}/.zshrc
    - contents:
      - WORDCHARS=''
{% endif %}

{% if salt['file.file_exists' ]('/Applications/TextMate.app/Contents/Resources/mate') %}
Symlink TextMate 'mate' cli tool into path:
  file.symlink:
    - name: {{ pillar['home'] }}/bin/mate
    - target: /Applications/TextMate.app/Contents/Resources/mate
{% endif %}

# TODO:pre-commit,jsonschema install/symlink
#      pylint "/"
#      youtube-dl "/"
