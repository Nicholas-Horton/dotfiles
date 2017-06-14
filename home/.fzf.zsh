# Setup fzf
# ---------
if [[ ! "$PATH" == */home/nhorton/.fzf/bin* ]]; then
  export PATH="$PATH:/home/nhorton/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/nhorton/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/nhorton/.fzf/shell/key-bindings.zsh"

# Filter .gitignore
# ------------
if command -v rg >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='rg --hidden --ignore-file .git -g "" --files'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200"
  export FZF_DEFAULT_OPTS='--height 40% --reverse --bind ctrl-u:unix-line-discard+top'
fi
