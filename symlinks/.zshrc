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
alias gs='git status -sb'
alias grm="git status | grep deleted | awk '{print \$3}' | xargs git rm"
alias gsh='git show'
alias gdc='git diff --cached'
alias gwt='git whatchanged'
alias gr='git rebase'
alias gri='git rebase --interactive'

# grc overrides for ls (requires `brew install coreutils`)
if command -v gls &>/dev/null; then
    alias ls='gls -F --color'
    alias ll='gls -lAh --color'
    alias la='gls -AF --color'
fi

################################################################################
# Environment variables
################################################################################
export EDITOR='subl -w'
PROMPT='%n in %~ %# '
export PATH="${HOME}/.bin:${PATH}"

################################################################################
# Initialize integrations
################################################################################
# Travis gem
[ -f ${HOME}/.travis/travis.sh ] && source ${HOME}/.travis/travis.sh

# rbenv
command -v rbenv &>/dev/null && eval "$(rbenv init -)"

# iTerm2
test -e ${HOME}/.iterm2.zsh && source ${HOME}/.iterm2.zsh

# zsh autocompletion
autoload -Uz compinit && compinit

################################################################################
# Miscellaneous
################################################################################
# Make sure the [fn] + [delete] key results in a forward delete, not a ~
bindkey "^[[3~" delete-char

# Load any private configurations that I don't want to push to GitHub
[ -f ${HOME}/.zshrc.private ] && source ${HOME}/.zshrc.private

# Set a title for the current tab
function title { echo -ne "\033]0;"$*"\007" }