#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

## Aliases
alias ls='ls --color=auto'
alias ll='ls -lv --group-directories-first'
alias vi='vim'

## Helpers
# Find a file by pattern
function ff() { find . -type f -iname '*'"$*"'*' -ls ; }
# Find file and execute command on that file
function fe() { find . -type f -iname '*'"${1:-}"'*' \
	-exec ${2:-file} {} \; ; }

function my_ip() # Get IP adress on ethernet.
{
	MY_IP=$(/sbin/ifconfig eth0 | awk '/inet/ { print $2 } ' | sed -e s/addr://)
	echo ${MY_IP:-"Not connected"}
}


# >>>>BEGIN ADDED BY CNCHI INSTALLER<<<< #
BROWSER=/usr/bin/chromium
EDITOR=/usr/bin/nano
# >>>>>END ADDED BY CNCHI INSTALLER<<<<< #
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"

## Git command line QoL improvements
parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

evil_git_dirty() {
	[[ $(git diff --shortstat 2> /dev/null | tail -n1) != "" ]] && echo "*"
}

export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\]\[\033[0;31m\]\$(evil_git_dirty)\[\033[0m\]\$ "

## work stuff
source ~/.work_bashrc
## /work stuff

# Display Archey3, if command exists
command -v archey3 >/dev/null 2>&1 && archey3

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
