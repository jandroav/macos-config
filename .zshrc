# Instant prompt configuration for Powerlevel10k
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Oh My Zsh configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(
  aws
  azure
  colorize
  command-not-found
  docker
  gcloud
  gh
  git
  git-prompt
  golang
  gpg-agent
  helm
  jira
  keychain
  kubectl
  kubectx
  minikube
  mvn
  npm
  pip
  python
  ssh
  ssh-agent
  terraform
  vscode
  zsh-history-substring-search
)

# Keychain plugin configuration
zstyle :omz:plugins:keychain agents gpg,ssh

# Prompt configuration
RPS1='$(kubectx_prompt_info)'  # Right prompt
PROMPT="$PROMPT"'$(kubectx_prompt_info)'  # Left prompt

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Path configurations
export PATH="/opt/homebrew/opt/ruby@3.1/bin:$PATH"
export PATH="$(gem environment gemdir)/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/opt/gnu-getopt/bin:$PATH"
export PATH="$PATH:$(go env GOPATH)/bin"
export PATH="$PATH:$HOME/.pulumi/bin"
export MAVEN_HOME="$HOME/.sdkman/candidates/maven/3.9.8/bin"
export PATH="$MAVEN_HOME:$PATH"
export CLOUDSDK_HOME="/opt/homebrew/share/google-cloud-sdk"

# SDKMAN configuration
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

# Aliases
alias ls='exa -lra'
alias c='clear'
alias h='history'
alias ga='git add .'
alias gc='git commit -m'
alias gp='git push'
alias gpl='git pull'
alias gs='git status'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gcm='git checkout master'
alias e='exit'
alias r='rename_wezterm_title $1'
alias cat='ccat'

# Source additional configurations
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
eval "$(zoxide init zsh)"
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh

# Key bindings for zsh-history-substring-search
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# Brew command-not-found handler
HB_CNF_HANDLER="$(brew --repository)/Library/Taps/homebrew/homebrew-command-not-found/handler.sh"
[[ -f "$HB_CNF_HANDLER" ]] && source "$HB_CNF_HANDLER"
