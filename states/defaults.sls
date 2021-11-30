# AppleSystemWide/Finder
Send screenshots to folder where gdrive syncs:
  macdefaults.write:
    - name: location
    - domain: com.apple.screencapture
    - vtype: string
    - value: {{ pillar['home'] }}/Documents/screenshots
    - user: {{ pillar['user'] }}

Show status bar (disk space reminder):
  macdefaults.write:
    - name: ShowStatusBar
    - domain: com.apple.finder
    - vtype: bool
    - value: true
    - user: {{ pillar['user'] }}

Allow text selection in Quick Look:
  macdefaults.write:
    - name: QLEnableTextSelection
    - domain: com.apple.finder
    - vtype: bool
    - value: true
    - user: {{ pillar['user'] }}

New window points to home:
  macdefaults.write:
    - name: NewWindowTarget
    - domain: com.apple.finder
    - vtype: string
    - value: PfHm
    - user: {{ pillar['user'] }}

Use column view in Finder:
  macdefaults.write:
    - name: FXPreferredViewStyle
    - domain: com.apple.finder
    - vtype: string
    - value: clmv
    - user: {{ pillar['user'] }}

Disable crazymaking crazyness dashes:
  macdefaults.write:
    - name: NSAutomaticDashSubstitutionEnabled
    - domain: NSGlobalDomain
    - vtype: bool
    - value: true
    - user: {{ pillar['user'] }}

Disable crazynessmaking demonquotes:
  macdefaults.write:
    - name: NSAutomaticQuoteSubstitutionEnabled
    - domain: NSGlobalDomain
    - vtype: bool
    - value: false
    - user: {{ pillar['user'] }}

#menubar-y
Add VPN to menubar: #TODO - less whackadoodle https://superuser.com/q/398071
  cmd.run:
    - name: /usr/bin/open /System/Library/CoreServices/Menu\ Extras/VPN.menu
    - unless:
      - /usr/bin/grep VPN {{ pillar['home'] }}/Library/Preferences/com.apple.systemuiserver.plist
    - runas: {{ pillar['user'] }}

Show percentage by battery:
  macdefaults.write:
    - name: ShowPercent
    - domain: com.apple.menuextra.battery
    - vtype: string
    - value: 'True'
    - user: {{ pillar['user'] }}

Restart menubar:
  cmd.run:
    - name: /usr/bin/killall SystemUIServer
    - runas: {{ pillar['user'] }}
    - onchanges:
      - macdefaults: Show percentage by battery

# AppleApps
Show all processes in Activity Monitor:
  macdefaults.write:
    - name: ShowCategory
    - domain: com.apple.ActivityMonitor
    - vtype: int
    - value: 100
    - user: {{ pillar['user'] }}

{% for key in ('Default Window Settings', 'Startup Window Settings') %}
Set Novel theme/profile in Terminal for {{ key }}:
  macdefaults.write:
    - name: {{ key }}
    - domain: com.apple.Terminal
    - vtype: string
    - value: 'Novel'
    - user: {{ pillar['user'] }}
{% endfor %}

Show Safari Statusbar:
  macdefaults.write:
    - name: ShowStatusBar
    - domain: com.apple.Safari
    - vtype: bool
    - value: true
    - user: {{ pillar['user'] }}

Show DevelopMenu Safari:
  macdefaults.write:
    - name: IncludeDevelopMenu
    - domain: com.apple.Safari
    - vtype: bool
    - value: true
    - user: {{ pillar['user'] }}

Don't Auto-Open Safari Downloads:
  macdefaults.write:
    - name: AutoOpenSafeDownloads
    - domain: com.apple.Safari
    - vtype: bool
    - value: false
    - user: {{ pillar['user'] }}

# Autopkg
Point autopkg at local munki repo:
  macdefaults.write:
    - name: MUNKI_REPO
    - domain: com.github.autopkg
    - vtype: string
    - value: '/Users/Shared/munki_repo'
    - user: {{ pillar['user'] }}
