# ZSH options
setopt sharehistory
setopt extendedhistory
setopt prompt_subst
autoload -Uz compinit && compinit
autoload -U colors && colors
autoload -U promptinit && promptinit

bindkey -e

zstyle ':compinstall filename' '/home/nhorton/.zshrc'
zstyle ':completion:*:killall:*' command 'ps -u $USER -o cmd'

# VAR SETTINGS
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
REPORTTIME=10

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"

# Added by fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# =----------------------------------=
# |            Helpers               |
# |                                  |
# =----------------------------------=
#
# =- Find a file by pattern -=
function ff()
{
  find . -type f -iname '*'"$*"'*' -ls ;
}

# Find file and execute command on that file
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

function parse_git_branch()
{
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

function evil_git_dirty()
{
	[[ $(git diff --shortstat 2> /dev/null | tail -n1) != "" ]] && echo "*"
}

## Aliases
alias ls='ls --color=auto'
alias ll='ls -lv --group-directories-first'
alias vi='vim'
alias vim="nvim"

# ZSH Key bindings, for new bindings, 'cat' and hit the key to see code
bindkey "^[[H" beginning-of-line      #HOME
bindkey "^[[F" end-of-line            #END
bindkey "^[[3~" delete-char           #DELETE
bindkey "^[[1;5C" forward-word        #CTRL+Right
bindkey "^[[1;5D" backward-word       #CTRL+Left

PS1='%{$reset_color%}%n@%m %{$fg[green]%}%~%{$fg[yellow]%}$(parse_git_branch)%{$fg[red]%}$(evil_git_dirty)%{$reset_color%}$ '

## work stuff
source ~/.work_bashrc
## /work stuff

# Display Archey3, if command exists
command -v archey3 >/dev/null 2>&1 && archey3

