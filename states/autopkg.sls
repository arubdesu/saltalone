# get autopkg installer:
#   file.managed:
#     - name: /tmp/autopkg-2.0.2.pkg
#     - source: https://github.com/autopkg/autopkg/releases/download/v2.0.2/autopkg-2.0.2.pkg
#     - source_hash: 5c408d18fb1977942fc48d23261ca29b6d4acff26d144a2b8e008546f771190a
    # - unless:

Setup autopkg dirs:
  file.directory:
    - user: {{ pillar['user'] }}
    - names:
      - {{ pillar['home'] }}/Library/AutoPkg
      - {{ pillar['home'] }}/Library/AutoPkg/Cache
      - {{ pillar['home'] }}/Library/AutoPkg/RecipeOverrides
      - {{ pillar['home'] }}/Library/AutoPkg/RecipeRepos