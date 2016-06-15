################################################################################
# Aliases
################################################################################
alias maek='make'

# Alias `git` to `hub` if it exists.
commands -v hub &>/dev/null && alias git='hub'

# More git aliases
alias gti='git'
alias g='git'
alias ga='git add'
alias gl='git pull'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gp='git push'
alias gd='git diff'
alias gc='git commit -v'
alias gco='git checkout'
alias gb='git branch'
alias gs='git status -sb' # upgrade your git if -sb breaks for you. it's fun.
alias grm="git status | grep deleted | awk '{print \$3}' | xargs git rm"

# grc overrides for ls (requires `brew install coreutils`)
if command -v gls &>/dev/null; then
    alias ls='gls -F --color'
    alias l='gls -lAh --color'
    alias ll='gls -l --color'
    alias la='gls -A --color'
fi

################################################################################
# Environment variables
################################################################################
export EDITOR='subl -w'
PROMPT='%n in %~ %# '

################################################################################
# Initialize integrations
################################################################################
# Travis gem
[ -f ${HOME}/.travis/travis.sh ] && source ${HOME}/.travis/travis.sh

# rbenv
command -v rbenv &>/dev/null && eval "$(rbenv init -)"

# iTerm2
test -e ${HOME}/.iterm2.zsh && source ${HOME}/.iterm2.zsh

################################################################################
# Miscellaneous
################################################################################
# Make sure the [fn] + [delete] key results in a forward delete, not a ~
bindkey "^[[3~" delete-char
