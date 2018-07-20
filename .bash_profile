## git alias
alias gloga='git log --oneline --decorate --graph --all'
alias glog='git log --oneline --decorate --graph'
alias gpl='git pull'
alias gs='git status'
alias gp='git push'
alias gpf='git push -f'
alias gf='git fetch'
alias gd='git diff'
alias gc='git commit'
alias gck='git checkout'
alias grb='git rebase -i'
alias gmg='git merge'
alias gbr='git branch'
alias grs='git reset'
alias grsh='git reset --hard'
alias gsh='git show'
alias grc='git recap'
alias gall='git add .'
alias ga='git add'

alias ls='ls -al --color'

alias grep='grep --color=tty'

source ~/.bashrc

# Load in the git branch prompt script.
source ~/.git-prompt.sh
