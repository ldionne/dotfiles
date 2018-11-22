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
alias grh='git reset --hard'
alias gri='git rebase --interactive'
alias grm="git status | grep deleted | awk '{print \$3}' | xargs git rm"
alias gs='git status -sb'
alias gsh='git show'
alias gti='git'
alias gwt='git whatchanged'

# grc overrides for ls (requires `brew install coreutils`)
if command -v gls &>/dev/null; then
    alias ls='gls -F --color'
    alias ll='gls -lAh --color'
    alias la='gls -AF --color'
fi

# use colordiff instead of diff if installed
if command -v colordiff &>/dev/null; then
    alias diff='colordiff'
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
if [[ -f "${HOME}/.travis/travis.sh" ]]; then
    source "${HOME}/.travis/travis.sh"
fi

# rbenv
command -v rbenv &>/dev/null && eval "$(rbenv init -)"

# iTerm2
if [[ -f "${HOME}/.iterm2_shell_integration.zsh" ]]; then
    source "${HOME}/.iterm2_shell_integration.zsh"
fi

# zsh autocompletion
autoload -Uz compinit && compinit

# fzf key bindings
if [[ -f "${HOME}/.fzf.zsh" ]]; then
    source "${HOME}/.fzf.zsh"
fi

################################################################################
# Miscellaneous
################################################################################
# Make sure the [fn] + [delete] key results in a forward delete, not a ~
bindkey "^[[3~" delete-char

# Load any private configurations that I don't want to push to GitHub
if [[ -f "${HOME}/.zshrc.private" ]]; then
    source "${HOME}/.zshrc.private"
fi
export PATH="${HOME}/.bin.private:${PATH}"

# Make sure Python packages installed with `pip install --user` can be found in the PATH
export PATH="${PATH}:${HOME}/Library/Python/2.7/bin"

# Set a title for the current tab
function title { echo -ne "\033]0;"$*"\007" }

# Restart all failed Travis jobs of a numbered build
function travis_restart_failed() {
  build=${1}
  travis show ${build} | grep -E "failed|errored" | grep "#" | cut -d " " -f 1 | cut -c 2- | xargs -L 1 travis restart
}

# Function to download WG21 papers
function download-paper() {
    paper="${1}"
    url="$(curl --silent "https://wg21.link/${paper}" | cut -f 4 -d ' ')"
    wget "${url}"
}

# Utilities to work with LLVM lit
function git-repo-root() {
    git rev-parse --show-toplevel
}

function find-llvm-lit() {
    root="${1}"
    realpath "$(find "${root}" -type f -perm +111 -name llvm-lit -print)"
}

alias lit='$(find-llvm-lit $(git-repo-root))'

# Get the SVN revision from a git commit in the LLVM monorepo
function llvm-svn-rev() {
    commit="${1}"
    svn="$(git show "${commit}" | grep git-svn-rev | cut -d ':' -f 2 | tr -d '[:space:]')"
    echo "r${svn}"
}

# Detects the sysroot of a Clang compiler and echoes it.
function detect-clang-sysroot() {
    cxx=${1}
    current_is_sysroot=false
    for arg in $(echo | ${cxx} -v -x c++ - 2>&1 | grep isysroot); do
        case "${arg}" in
            -isysroot)
            current_is_sysroot=true
            ;;
            *)
            if [[ "${current_is_sysroot}" = true ]]; then
                echo "${arg}"
                break
            fi
            ;;
        esac
    done
}

# Detect the Cellar path of a Homebrew package
function brew-path() {
    formula=${1}
    brew info "${formula}" | grep Cellar | cut -d ' ' -f 1
}

# Function to easily download a Clang for MacOS from the LLVM releases page
function download-mac-clang() {
    version="${1}"
    directory="${2}"
    mkdir -p "${directory}"
    URL="http://releases.llvm.org/${version}/clang+llvm-${version}-x86_64-apple-darwin.tar.xz"
    wget "${URL}" --quiet -O - | tar -xj --strip-components=1 -C "${directory}"
}
