# this is for future CI/CD where deploy tool already put salt in place
# {% if not salt['file.file_exists']('/usr/local/bin/autopkg') %}
# Get autopkg installer:
#   file.managed:
#     - name: /tmp/autopkg-2.0.2.pkg
#     - source: https://github.com/autopkg/autopkg/releases/download/v2.0.2/autopkg-2.0.2.pkg
#     - source_hash: 5c408d18fb1977942fc48d23261ca29b6d4acff26d144a2b8e008546f771190a
#
# {% if salt['file.file_exists']('/tmp/autopkg-2.0.2.pkg') %}
# Install autopkg:
#   macpackage.installed:
#     - name: /tmp/autopkg-2.0.2.pkg
# {% endif %}
# {% endif %}
#
# Setup autopkg dirs:
#   file.directory:
#     - user: {{ pillar['user'] }}
#     - names:
#       - {{ pillar['home'] }}/Library/AutoPkg
#       - {{ pillar['home'] }}/Library/AutoPkg/Cache
#       - {{ pillar['home'] }}/Library/AutoPkg/RecipeOverrides
#       - {{ pillar['home'] }}/Library/AutoPkg/RecipeRepos

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
# since cmd.run keeps swallowing the glob'd app name e.g. in 1Password space 7 etc.
{% for app in pillar['installs'] %}
Install with autopkg - {{ app }}:
  cmd.run:
    - runas: {{ pillar['user'] }}
    - name: /usr/local/bin/autopkg install '{{ app }}'
    - unless:
      - /bin/test -d /Applications/'{{ app }}.app'
{% endfor %}
# names don't match recipe exact, so pulling out of pillar
{% if not salt['file.directory_exists']('/Applications/1Password 7.app') %}
Install 1Password with autopkg:
  cmd.run:
    - runas: {{ pillar['user'] }}
    - name: /usr/local/bin/autopkg install 1Password
{% endif %}
{% if not salt['file.directory_exists']('/Applications/Hex Fiend.app') %}
Install 1Password with autopkg:
  cmd.run:
    - runas: {{ pillar['user'] }}
    - name: /usr/local/bin/autopkg install HexFiend
{% endif %}
# inconsistently named and we hatesssss spacesssss 
{% if not salt['file.directory_exists']('/Applications/Suspicious Package.app') %}
Install SuspiciousPackageApp with autopkg:
  cmd.run:
    - runas: {{ pillar['user'] }}
    - name: /usr/local/bin/autopkg install SuspiciousPackageApp
{% endif %}
{% endif %}
