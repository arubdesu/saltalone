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

Setup bash_profile, including symlink to python2.7 tools installed by pip:
  file.append:
    - name: {{ pillar['home'] }}/.bash_profile
    - text:
      - export PATH="$PATH:{{ pillar['home'] }}/Library/Python/2.7/bin:{{ pillar['home'] }}/bin"
      - export LC_ALL='en_US.UTF-8'
      - export LANG='en_US.UTF-8'
      # ~borrowed~ wholesale copied from https://github.com/hjuutilainen/dotfiles/blob/master/.bash_profile
      # Number of lines in the history file
      - export HISTFILESIZE=1000000
      # Number of entries in the history file
      - export HISTSIZE=1000000
      # History file location
      - export HISTFILE=~/.bash_history
      # Display timestamps as "yyyy-mm-dd HH:MM:SS"
      - export HISTTIMEFORMAT="%F %T "
      # Ignore duplicates
      - export HISTCONTROL=ignoreboth:erasedups
      # Ignore stuff that we'd definitely never up-arrow to
      - export HISTIGNORE=$'history:ping:which:exit:[ \t]*'
      # Attempt to save all lines of a multiple-line command in the same history entry
      - shopt -s cmdhist
      # Appended instead of overwriting the history file
      - shopt -s histappend
      # Case-insensitive filename expansion
      - shopt -s nocaseglob
      # Make sure every simultaneous session has the same history
      - export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

Case-insensitive tab completion!:
  file.managed:
    - name: /etc/inputrc
    - contents:
      - #tells readline to complete filenames regardless of case https://superuser.com/a/90202
      - set completion-ignore-case on

# eventually https://cloud.google.com/sdk/docs/downloads-interactive#silent
{%- if salt['file.file_exists' ]('/Applications/TextMate.app/Contents/Resources/mate') %}
Move TextMate mate cli into path:
  file.symlink:
    - name: {{ pillar['home'] }}/bin/mate
    - target: /Applications/TextMate.app/Contents/Resources/mate
{%- endif %}

# TODO:jsonschema install/symlink
#      pylint "/"
#      youtube-dl "/"
