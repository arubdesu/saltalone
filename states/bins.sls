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
      - /Users/Shared/repo/catalogs
      - /Users/Shared/repo/icons
      - /Users/Shared/repo/pkgs
      - /Users/Shared/repo/pkgsinfo
      - /Users/Shared/repo/icons
    - makedirs: True

{% if not salt['file.search']('/private/etc/pam.d/sudo', 'auth       sufficient     pam_tid.so') %}
TouchID for sudo because the internet:
  file.append:
    - name: /private/etc/pam.d/sudo
    - text:
      - auth       sufficient     pam_tid.so
{% endif %}

{% if not salt['file.search'](pillar['home'] ~ '/.bash_profile', '/Library/Python/2.7/bin') %}
Tooo many var expansions, sets up path in bash_profile:
  file.append:
    - name: {{ pillar['home'] }}/.bash_profile
    - text:
      - export PATH="$PATH:{{ pillar['home'] }}/Library/Python/2.7/bin:{{ pillar['home'] }}/bin"
{% endif %}

{% for line in pillar['bashers'] %}
{% if not salt['file.search'](pillar['home'] ~ '/.bash_profile', line) %}
Customize bash_profile, add line - {{ line }}:
  file.append:
    - name: {{ pillar['home'] }}/.bash_profile
    - text:
      - {{ line }}
{% endif %}
{% endfor %}

Case-insensitive tab completion!:
  file.managed:
    - name: /etc/inputrc
    - contents:
      - #tells readline to complete filenames regardless of case https://superuser.com/a/90202
      - set completion-ignore-case on

# eventually https://cloud.google.com/sdk/docs/downloads-interactive#silent
{% if salt['file.file_exists' ]('/Applications/TextMate.app/Contents/Resources/mate') %}
Symlink TextMate 'mate' cli tool into path:
  file.symlink:
    - name: {{ pillar['home'] }}/bin/mate
    - target: /Applications/TextMate.app/Contents/Resources/mate
{% endif %}

# TODO:jsonschema install/symlink
#      pylint "/"
#      youtube-dl "/"
