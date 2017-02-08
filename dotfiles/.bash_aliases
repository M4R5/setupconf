# Aliases : grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias pgrep='pgrep --list-full'

# Aliases : ls
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias sl='ls'
alias ls='ls --color=auto'

# Aliases tree
alias t="tree -Cl"
alias ta="tree -Clah"

# Aliases cd
alias ..="cd .."

cs() {
    cd "$1" && ls
}

bs() {
    cd .. && ls
}

# Aliases git
alias ga="git add"
alias gc="git commit"
alias gd="git diff"
alias glog="git log --oneline --color --decorate --graph"
alias gst="git status"

# Others
alias reload="source \${HOME}/.bashrc"
alias vim="vim -O"
