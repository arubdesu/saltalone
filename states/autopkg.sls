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
{% endif %}
# since path/recipe discrepancies, cmd.run kept swallowing glob'd app names e.g. in 1Password space 7, etc.
# see bottom of autopkg_costumes for previous jinja format, py is way shorter
