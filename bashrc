#!/bin/bash

# return if not interactive
[ "$(echo $- | grep -c i)" -eq 0 ] && return

# environment
export HISTCONTROL=ignoreboth
export EDITOR=nvim
export VISUAL=nvim

PATH=$(echo "$HOME/."{osoy,cargo,yarn}"/bin" "$PATH" | tr ' ' ':')
export PATH

# shellcheck disable=SC2089
PS1='\W$(git branch 2>/dev/null | sed -n "s/^* \(.*\)$/(\1)/p")'
PS1="$PS1$([ $EUID -eq 0 ] && echo '#' || echo '$') "
# shellcheck disable=SC2090
export PS1
# shellcheck disable=SC2154
export PROMPT_COMMAND='_ec=$?; [ $_ec -ne 0 ] && printf "\e[1;7;31mE%d\e[m\n" $_ec'

# default options
alias rm='rm -i'
alias mv='mv -i'
alias ls='ls --color'
alias grep='grep --color'
alias tree='tree -C'
alias tmux='tmux -2'
alias date='date +"%F %T %:z %b %a%W"'
alias lsblk='lsblk -o name,size,fstype,mountpoint,label,ro,rm'
alias feh='feh --conversion-timeout 2'

# shorthand
alias b='cd $OLDPWD'
alias l='ls -lhtA --time-style=long-iso'
alias x='startx'
alias oy='osoy'
alias sys='sudo systemctl'
alias bat='acpi | sed "s/^Battery [0-9]\+: //;s/,//g"'

# functions
v() {
  if [ $# -eq 0 ]
  then
    if command -v fzf >/dev/null 2>&1
    then
      if git rev-parse --git-dir >/dev/null 2>&1
      then nvim -c 'GFiles!'
      else nvim -c 'Files!'
      fi
    else nvim .
    fi
  else nvim "$@"
  fi
}

t() {
  if [ $# -eq 0 ]
  then tmux attach-session -t 0 2>/dev/null || tmux new-session -s 0
  else tmux "$@"
  fi
}

oc() {
  cd "$(osoy locate -r "$1")" && [ -n "$2" ] && git checkout "$2"
  return 0
}

init-nvm() {
  if [ -f /usr/share/nvm/init-nvm.sh ]
  then source /usr/share/nvm/init-nvm.sh
  elif command -v brew >/dev/null && [ -s "$(brew --prefix)/opt/nvm/nvm.sh" ]
  then source "$(brew --prefix)/opt/nvm/nvm.sh"
  fi
}
