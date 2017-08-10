# =----------------------------------------------------------------------------=
# |                                                                            |
# |                               ZSH Options                                  |
# |                                                                            |
# =----------------------------------------------------------------------------=
#
unsetopt share_history
setopt prompt_subst
autoload -Uz compinit && compinit
autoload -U colors && colors
autoload -U promptinit && promptinit

bindkey -e

zstyle ':compinstall filename' '~/.zshrc'
zstyle ':completion:*:killall:*' command 'ps -u $USER -o cmd'

# =----------------------------------------------------------------------------=
# |                                                                            |
# |                              ENV Variables                                 |
# |                                                                            |
# =----------------------------------------------------------------------------=
#
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
REPORTTIME=10
EDITOR=vi
COUNTRY=US
export LANG="en_US.UTF-8"

# =----------------------------------------------------------------------------=
# |                                                                            |
# |                           Application-specific                             |
# |                                                                            |
# =----------------------------------------------------------------------------=
#
# Ruby
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"

# FZF -- Source settings, if they exist
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# =----------------------------------------------------------------------------=
# |                                                                            |
# |                                Helpers                                     |
# |                                                                            |
# =----------------------------------------------------------------------------=
#
# =-- FZF Git status files --=
# Usage: git checkout fst
function fst()
{
  { git diff --cached --name-only & git ls-files  -dom --exclude-standard; } | sort -u | fzf -m --preview "cat {}"
}

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

# =-- Get IP adress on ethernet --=
function my_ip()
{
	MY_IP=$(/sbin/ifconfig eth0 | awk '/inet/ { print $2 } ' | sed -e s/addr://)
	echo ${MY_IP:-"Not connected"}
}

# =-- Get the branch name when in git repo --=
function parse_git_branch()
{
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# =-- Figure out if there are staged changes --=
function git_dirty()
{
	[[ $(git diff --shortstat 2> /dev/null | tail -n1) != "" ]] && echo "*"
}

# =----------------------------------------------------------------------------=
# |                                                                            |
# |                                 Aliases                                    |
# |                                                                            |
# =----------------------------------------------------------------------------=
#

if command -v exa >/dev/null 2>&1; then
  alias ls='exa --color=auto'
  alias ll='exa -Glag --group-directories-first'
else
  alias ls='ls --color=auto'
  alias ll='ls -lv --group-directories-first'
fi

if command -v nvim >/dev/null 2>&1; then
  alias vi='nvim'
  alias vim='nvim'
elif command -v vim >/dev/null 2>&1; then
  alias vi='vim'
fi

# ZSH Key bindings, for new bindings, 'cat' and hit the key to see code
bindkey "^[[H"    beginning-of-line #HOME
bindkey "^[[F"    end-of-line       #END
bindkey "^[[3~"   delete-char       #DELETE
bindkey "^[[1;5C" forward-word      #CTRL+Right
bindkey "^[[1;5D" backward-word     #CTRL+Left

# =----------------------------------------------------------------------------=
# |                                                                            |
# |                                  Prompt                                    |
# |                                                                            |
# =----------------------------------------------------------------------------=
#
PS1='%{$reset_color%}%{$fg[blue]%}%n@%m %{$fg[green]%}%~%{$fg[yellow]%}$(parse_git_branch)%{$fg[red]%}$(git_dirty)%{$reset_color%}$ '

## work stuff
[ -f ~/.work_bashrc ] && source ~/.work_bashrc
## /work stuff

## VIM stuff
[ -f "~/.vim/plugged/gruvbox/gruvbox_256palette.sh" ] && source "~/.vim/plugged/gruvbox/gruvbox_256palette.sh"

if command -v xcape >/dev/null 2>&1; then
  xcape -t 750
fi
## /VIM stuff

# Display Archey3, if command exists
command -v archey3 >/dev/null 2>&1 && archey3

