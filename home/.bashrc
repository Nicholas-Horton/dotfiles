#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# =----------------------------------=
# |         ENV Variables            |
# |                                  |
# =----------------------------------=
#
EDITOR=vi

# =----------------------------------=
# |            Helpers               |
# |                                  |
# =----------------------------------=
#
# =-- Find a file by pattern --=
function ff()
{
  find . -type f -iname '*'"$*"'*' -ls ;
}
# =-- Find file and execute command on that file --=
function fe()
{
  find . -type f -iname '*'"${1:-}"'*' \
	-exec ${2:-file} {} \; ;
}

function my_ip() # Get IP adress on ethernet.
{
	MY_IP=$(/sbin/ifconfig eth0 | awk '/inet/ { print $2 } ' | sed -e s/addr://)
	echo ${MY_IP:-"Not connected"}
}

# =-- Get the branch name when in git repo --=
parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# =-- Figure out if there are staged changes --=
git_dirty() {
	[[ $(git diff --shortstat 2> /dev/null | tail -n1) != "" ]] && echo "*"
}


# =----------------------------------=
# |            Aliases               |
# |                                  |
# =----------------------------------=
#
alias ls='ls --color=auto'
alias ll='ls -lv --group-directories-first'

if command -v nvim >/dev/null 2>&1; then
  alias vi='nvim'
  alias vim='nvim'
elif command -v vim >/dev/null 2>&1; then
  alias vi='vim'
fi

# =----------------------------------=
# |            Prompt                |
# |                                  |
# =----------------------------------=
#
export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\]\[\033[0;31m\]\$(git_dirty)\[\033[0m\]\$ "

# =----------------------------------=
# |      Application-specific        |
# |                                  |
# =----------------------------------=
#
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

if command -v xcape >/dev/null 2>&1; then
  xcape -t 750
fi

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"

# =----------------------------------=
# |      Local configuration         |
# |                                  |
# =----------------------------------=
#
## work stuff
[ -f ~/.work_bashrc ] && source ~/.work_bashrc
## /work stuff


# =----------------------------------=
# |          Post-config             |
# |                                  |
# =----------------------------------=
#
# Display Archey3, if command exists
command -v archey3 >/dev/null 2>&1 && archey3
