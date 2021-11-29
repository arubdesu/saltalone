# in case autopkg isn't already on the system, otherwise this is chicken before egg as I install salt with autopkg
{% if not salt['file.file_exists']('/usr/local/bin/autopkg') %}
Get autopkg installer:
  file.managed:
    - name: /tmp/autopkg-2.3.1.pkg
    - source: https://github.com/autopkg/autopkg/releases/download/v2.3.1/autopkg-2.3.1.pkg
    - source_hash: f1a9ecb746f3f154db7efd657a29e33c3b0e9d3bdbcdfbed5f191c33ee1fcabc

{% if salt['file.file_exists']('/tmp/autopkg-2.3.1.pkg') %}
Install autopkg:
  macpackage.installed:
    - name: /tmp/autopkg-2.3.1.pkg
{% endif %}
{% endif %}

# _almost_ happy with/proud of this stuff
{% if salt['file.file_exists']('/usr/local/bin/autopkg') %}
{% for repo in pillar['repos'] %}
Checkout repos of autopkg recipes once - {{ repo }}:
  cmd.run:
    - runas: {{ pillar['user'] }}
    - name: /usr/local/bin/autopkg repo-add '{{ repo }}'
    - unless:
      - /bin/test -d {{ pillar['home'] }}/Library/AutoPkg/RecipeRepos/com.github.autopkg.'{{ repo }}'
{% endfor %}
{% for app in pillar['plain_apps'] %}
Install with autopkg - {{ app }}:
  cmd.run:
    - runas: {{ pillar['user'] }}
    - name: /usr/local/bin/autopkg install '{{ app }}'
    - unless:
      - /bin/test -d /Applications/'{{ app }}.app'
{% endfor %}
# since name discrepancies, cmd.run kept swallowing glob'd app names e.g. in 1Password space 7, etc.
{% if not salt['file.directory_exists']('/Applications/1Password 7.app') %}
Install 1Password with autopkg:
  cmd.run:
    - runas: {{ pillar['user'] }}
    - name: /usr/local/bin/autopkg install 1Password
{% endif %}
{% if not salt['file.directory_exists']('/Library/Screen Savers/Aerial.saver') %}
Install Aerial screen saver with autopkg:
  cmd.run:
    - runas: {{ pillar['user'] }}
    - name: /usr/local/bin/autopkg install Aerial
{% endif %}
{% if not salt['file.directory_exists']('/Applications/GitHub Desktop.app') %}
Install GitHub Desktop with autopkg:
  cmd.run:
    - runas: {{ pillar['user'] }}
    - name: /usr/local/bin/autopkg install GitHubDesktop
{% endif %}
{% if not salt['file.file_exists']('/usr/local/bin/git-lfs') %}
Install git-lfs with autopkg:
  cmd.run:
    - runas: {{ pillar['user'] }}
    - name: /usr/local/bin/autopkg install git-lfs
{% endif %}
{% if not salt['file.directory_exists']('/Applications/Hex Fiend.app') %}
Install Hex Fiend with autopkg:
  cmd.run:
    - runas: {{ pillar['user'] }}
    - name: /usr/local/bin/autopkg install HexFiend
{% endif %}
{% if not salt['file.file_exists']('/usr/local/bin/rg') %}
Install ripgrep with autopkg:
  cmd.run:
    - runas: {{ pillar['user'] }}
    - name: /usr/local/bin/autopkg install ripgrep
{% endif %}
{% if not salt['file.directory_exists']('/Applications/Recipe Robot.app') %}
Install SuspiciousPackageApp with autopkg:
  cmd.run:
    - runas: {{ pillar['user'] }}
    - name: /usr/local/bin/autopkg install 'Recipe Robot'
{% endif %}
{% if not salt['file.file_exists']('/usr/local/bin/shellcheck') %}
Install shellcheck with autopkg:
  cmd.run:
    - runas: {{ pillar['user'] }}
    - name: /usr/local/bin/autopkg install Shellcheck
{% endif %}
{% if not salt['file.directory_exists']('/Applications/Suspicious Package.app') %}
Install SuspiciousPackageApp with autopkg:
  cmd.run:
    - runas: {{ pillar['user'] }}
    - name: /usr/local/bin/autopkg install SuspiciousPackageApp
{% endif %}
# waiting on review/merge https://github.com/autopkg/hjuutilainen-recipes/pull/208
# {% if not salt['file.directory_exists']('/Applications/TextExpander.app') %}
# Install TextExpander with autopkg:
#   cmd.run:
#     - runas: {{ pillar['user'] }}
#     - name: /usr/local/bin/autopkg install TextExpander6
# {% endif %}
{% endif %}
