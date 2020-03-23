bashers:
  # ~borrowed~ wholesale copied from https://github.com/hjuutilainen/dotfiles/blob/master/.bash_profile
  - export LC_ALL='en_US.UTF-8'
  - export LANG='en_US.UTF-8'
  # HISTFILESIZE controls number of lines stored/loaded in history
  - export HISTFILESIZE=1000000
  # HISTSIZE number of entries loaded into memory from history file while session is running
  - export HISTSIZE=1000000
  - export HISTFILE=~/.bash_history
  # HISTTIMEFORMAT displays timestamps as "yyyy-mm-dd HH:MM:SS"
  - export HISTTIMEFORMAT="%F %T "
  # HISTCONTROL=ignoreboth:erasedups is supposed to ignore space before input, duplicates, and erase duplicates in history
  #  but not sure about across sessions etc., definitely ignores space with HISTIGNORE supposed to be adding explicit skips
  - export HISTCONTROL=ignoreboth:erasedups
  - export HISTIGNORE=$'history:ping:which:exit:[ \t]*'
  # cmdhist makes it compress multiple-line command in the same history entry
  - shopt -s cmdhist
  # histappend helps across muiltiple sessions, defintely doesn't overwrite, could be a source of conflict in other settings
  - shopt -s histappend
  # fish/zsh-alike non-case-sensitive tab expansion
  - shopt -s nocaseglob
  # PROMPT_COMMAND tries to ensure simultaneous sessions have the same history
  - export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"