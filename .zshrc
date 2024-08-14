export PATH="/opt/homebrew/opt/ruby@3.1/bin:$PATH"
GEMSDIR=$(gem environment gemdir)/bin
PATH=$GEMSDIR:$PATH
export PATH
alias ls='ls -ltra'
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
export PATH=$PATH:$(go env GOPATH)/bin

# add Pulumi to the PATH
export PATH=$PATH:$HOME/.pulumi/bin
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
export PATH="$HOME/.local/bin:{$PATH}"
eval "$(zoxide init zsh)"

export MAVEN_HOME="/Users/jandroav/.sdkman/candidates/maven/3.9.8/bin"
export PATH="$MAVEN_HOME:{$PATH}"
export PATH="/opt/homebrew/opt/gnu-getopt/bin:$PATH"
export EDITOR="zed"

eval "$(starship init zsh)"

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# First and only argument is the desired term title
function rename_wezterm_title {
  echo "\x1b]1337;SetUserVar=panetitle=$(echo -n $1 | base64)\x07"
}