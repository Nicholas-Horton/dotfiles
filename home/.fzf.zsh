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
if command -v ag >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='ag -g ""'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi
