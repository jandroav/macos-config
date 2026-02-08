if [[ $- == *i* ]]; then
  fastfetch || true
fi

alias gpl='git fetch && git pull'
alias gp='git push'
alias gcl='git clone'
alias gco='git checkout'
alias gcm='git commit -m'
alias gcb='git checkout -b'
alias gst='git status'
alias gd='git diff'
alias ga='git add'

alias cc='claude --teammate-mode tmux --dangerously-skip-permissions'
alias c='clear'

alias ls='eza'
alias ll='eza -l'
alias la='eza -a'
alias cat='bat'

alias cbt="/opt/homebrew/share/google-cloud-sdk/bin/cbt"

[[ ":$PATH:" != *":/opt/homebrew/opt/openjdk/bin:"* ]] && export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
[[ ":$PATH:" != *":$HOME/.local/bin:"* ]] && export PATH="$HOME/.local/bin:$PATH"

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
eval "$(starship init zsh)"
