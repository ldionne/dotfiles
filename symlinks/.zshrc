################################################################################
# Aliases
################################################################################
alias maek='make'

# Alias `git` to `hub` if it exists.
commands -v hub &>/dev/null && alias git='hub'

# More git aliases
alias g='git'
alias ga='git add'
alias gb='git branch'
alias gc='git commit -v'
alias gco='git checkout'
alias gd='git diff'
alias gdc='git diff --cached'
alias gl='git pull'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gp='git push'
alias gr='git rebase'
alias gri='git rebase --interactive'
alias grm="git status | grep deleted | awk '{print \$3}' | xargs git rm"
alias gs='git status -sb'
alias gsb='gs && gb'
alias gsh='git show'
alias gti='git'
alias gwt='git whatchanged'

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
export HISTSIZE=15000 # Maximum number of history lines kept per session
export SAVEHIST=100000 # Maximum number of history lines kept across all sessions
export HISTFILE=${HOME}/.zsh_history # File where history is kept

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

# fzf key bindings
[ -f ${HOME}/.fzf.zsh ] && source ${HOME}/.fzf.zsh

################################################################################
# Miscellaneous
################################################################################
# Make sure the [fn] + [delete] key results in a forward delete, not a ~
bindkey "^[[3~" delete-char

# Load any private configurations that I don't want to push to GitHub
[ -f ${HOME}/.zshrc.private ] && source ${HOME}/.zshrc.private

# Set a title for the current tab
function title { echo -ne "\033]0;"$*"\007" }

# Restart all failed Travis jobs of a numbered build
function travis_restart_failed() {
  build=${1}
  travis show ${build} | grep -E "failed|errored" | grep "#" | cut -d " " -f 1 | cut -c 2- | xargs -L 1 travis restart
}
