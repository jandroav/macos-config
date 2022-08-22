if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Universal variables
set -U EDITOR nvim
set -U USE_GKE_GCLOUD_AUTH_PLUGIN True

# $PATH list values
fish_add_path /usr/local/opt/openjdk@11/bin
fish_add_path /Users/alejandroalvarezvazquez

# abbrs (alias)
abbr c clear
abbr k kubectl
abbr kgp k get pods
abbr g 'git'
abbr ga 'git add'
abbr gb 'git branch'
abbr gbl 'git blame'
abbr gc 'git commit -m'
abbr gca 'git commit --amend -m'
abbr gco 'git checkout'
abbr gcp 'git cherry-pick'
abbr gd 'git diff'
abbr gf 'git fetch'
abbr gl 'git log'
abbr gm 'git merge'
abbr gp 'git push'
abbr gpf 'git push --force-with-lease'
abbr gpl 'git pull'
abbr gr 'git remote'
abbr grb 'git rebase'
abbr gs 'git status'
abbr gst 'git stash'

# fzf
fzf_configure_bindings
fzf_configure_bindings --directory=\cf
fzf_configure_bindings --git_status=\cs
fzf_configure_bindings --git_log=\cl

# functions
function gacp
  git add .
  git commit -m "uploaded changes"
  git push
end
