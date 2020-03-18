{% if  not salt['file.file_exists']('/usr/local/bin/autopkg') %}
Get autopkg installer:
  file.managed:
    - name: /tmp/autopkg-2.0.2.pkg
    - source: https://github.com/autopkg/autopkg/releases/download/v2.0.2/autopkg-2.0.2.pkg
    - source_hash: 5c408d18fb1977942fc48d23261ca29b6d4acff26d144a2b8e008546f771190a

Install autopkg:
  pkg.installed:
    - name: /tmp/autopkg-2.0.2.pkg
{% endif %}

Setup autopkg dirs:
  file.directory:
    - user: {{ pillar['user'] }}
    - names:
      - {{ pillar['home'] }}/Library/AutoPkg
      - {{ pillar['home'] }}/Library/AutoPkg/Cache
      - {{ pillar['home'] }}/Library/AutoPkg/RecipeOverrides
      - {{ pillar['home'] }}/Library/AutoPkg/RecipeRepos

{% for repo in pillar['repos'] %}
Checkout repos of autopkg recipes once - {{ repo }}:
  cmd.run:
    - user: {{ pillar['user'] }}
    - name: /usr/local/bin/autopkg repo-add '{{ repo }}'
    - unless:
      - /bin/test -d {{ pillar['home'] }}/Library/AutoPkg/RecipeRepos/com.github.autopkg.'{{ repo }}'
{% endfor %}

{% if salt['file.file_exists']('/usr/local/bin/autopkg') %}
{% for app in pillar['installs'] %}
Install with autopkg - {{ app }}:
  cmd.run:
    - user: {{ pillar['user'] }}
    - name: /usr/local/bin/autopkg install '{{ app }}'
    - unless:
      - /bin/test /Applications/'{{ app }}*'
{% endfor %}
{% endif %}
# funnily named, so pulling out of pillar
{% if not salt['file.directory_exists']('/Applications/Backup and Sync.app') %}
Install Google Backup and Sync with autopkg:
  cmd.run:
    - user: {{ pillar['user'] }}
    - name: /usr/local/bin/autopkg install BackupandSync
{% endif %}
# inconsistently named and we hatesssss spacesssss 
{% if not salt['file.directory_exists']('/Applications/Suspicious Package.app') %}
Install SuspiciousPackageApp with autopkg:
  cmd.run:
    - user: {{ pillar['user'] }}
    - name: /usr/local/bin/autopkg install SuspiciousPackageApp
{% endif %}
