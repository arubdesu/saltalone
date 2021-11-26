Position dock on right:
  macdefaults.write:
    - name: orientation
    - domain: com.apple.dock
    - vtype: string
    - value: right
    - user: {{ pillar['user'] }}

Hide dock:
  macdefaults.write:
    - name: autohide
    - domain: com.apple.dock
    - vtype: bool
    - value: true
    - user: {{ pillar['user'] }}

#TODO - convert all these to custom module via github.com/homebysix/docklib

# {% if salt['file.file_exists']('/usr/local/bin/dockutil') %}
#
# Add Archive Utility to dock:
#   cmd.run:
#     - name: /usr/local/bin/dockutil --add '/System/Library/CoreServices/Applications/Archive Utility.app'
#     - unless:
#       - /usr/local/bin/dockutil --find 'Archive Utility'
#     - runas: {{ pillar['user'] }}
#
# Add custom screenshot path to dock:
#   cmd.run:
#     - name: /usr/local/bin/dockutil --add {{ pillar['home'] }}/Documents/screenshots --view grid --display stack --sort dateadded
#     - unless:
#       - /usr/local/bin/dockutil --find screenshots
#     - runas: {{ pillar['user'] }}
#
# {% for item in pillar['dock_removals'] %}
# Remove unwanted items from dock - {{ item }}:
#   cmd.run:
#     - name: /usr/local/bin/dockutil --remove '{{ item }}'
#     - onlyif: /usr/local/bin/dockutil --find '{{ item }}'
#     - runas: {{ pillar['user'] }}
# {% endfor %}
#
# {% for each in pillar['dockapp_additions'] %}
# {% if salt['file.directory_exists']('/Applications/' ~ each ~ '.app') %}
#
# Add apps to dock - {{ each }}:
#   cmd.run:
#     - name: /usr/local/bin/dockutil --add '/Applications/{{ each }}.app'
#     - unless:
#       - /usr/local/bin/dockutil --find '{{ each }}'
#     - runas: {{ pillar['user'] }}
#
# {% endif %}
# {% endfor %}
#
# {% for other in pillar['dockother_additions'] %}
# {% if salt['file.directory_exists'](pillar['home'] ~ '/' ~ other) %}
# Add others to dock - {{ other }}:
#   cmd.run:
#     - name: /usr/local/bin/dockutil --add {{ pillar['home'] }}/{{ other }} --view grid --display stack --sort dateadded
#     - unless:
#       - /usr/local/bin/dockutil --find {{ other }}
#     - runas: {{ pillar['user'] }}
#
# {% endif %}
# {% endfor %}

{% endif %}
# # debug stuffs, as per https://stackoverflow.com/a/48673120: {- do salt.log.info(pillar['home'] ~ other) -}
# This made my login session fall down go boom... YMMV
# As mentioned above, more interested in switching to https://github.com/homebysix/docklib
# Restart dock:
#   cmd.run:
#     - name: /usr/bin/killall Dock
#     - runas: {{ pillar['user'] }}
#     - onchanges_any:
