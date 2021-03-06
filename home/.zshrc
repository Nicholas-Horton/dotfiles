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
export GPG_TTY=$(tty)

# =----------------------------------------------------------------------------=
# |                                                                            |
# |                           Application-specific                             |
# |                                                                            |
# =----------------------------------------------------------------------------=
#
# Ruby
if command -v rbenv >/dev/null 2>&1; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
  export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
fi

# FZF
if command -v fzf >/dev/null 2>&1; then
  # use ripgrep for fzf
  if command -v rg >/dev/null 2>&1; then
    export FZF_DEFAULT_COMMAND='rg -L --files'
  fi
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fi

# GPG
# Set GPG TTY
export GPG_TTY=$(tty)

# Refresh gpg-agent tty in case user switches into an X session
gpg-connect-agent updatestartuptty /bye >/dev/null

# =----------------------------------------------------------------------------=
# |                                                                            |
# |                                Helpers                                     |
# |                                                                            |
# =----------------------------------------------------------------------------=
#
# ======== FZF Git status files ========
# Usage: git checkout $(fst)
function fst()
{
  { git diff --cached --name-only & git ls-files  -dom --exclude-standard; } | sort -u | fzf -m --preview "cat {}"
}

# ====== Find a file by pattern ========
function ff()
{
  find . -type f -iname '*'"$*"'*' -ls ;
}

# ==== Branch name when in git repo ====
function parse_git_branch()
{
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# === Show working directory changes ===
function git_working_directory_changes_indicator()
{
	[[ $(git diff --shortstat 2> /dev/null | tail -n1) != "" ]] && echo "*"
}

# ======== Show indexed changes ========
function git_indexed_changes_indicator()
{
	[[ $(git diff --shortstat --cached 2> /dev/null | tail -n1) != "" ]] && echo "*"
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
bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line
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
PS1='%{$reset_color%}%{$fg[blue]%}%n@%m %{$fg[green]%}%~%{$fg[yellow]%}$(parse_git_branch)$(git_indexed_changes_indicator)%{$fg[red]%}$(git_working_directory_changes_indicator)%{$reset_color%}$ '

# Display neofetch, if command exists
command -v neofetch >/dev/null 2>&1 && neofetch

# =----------------------------------------------------------------------------=
# |                                                                            |
# |                                 External                                   |
# |                                                                            |
# =----------------------------------------------------------------------------=
#
# Source local file for stuff specific to this machine
[ -f ~/.local.zshrc ] && source ~/.local.zshrc

## VIM stuff
[ -f "~/.vim/plugged/gruvbox/gruvbox_256palette.sh" ] && source "~/.vim/plugged/gruvbox/gruvbox_256palette.sh"
## /VIM stuff

