################################################################################
# Aliases
################################################################################
alias maek='make'

# Git aliases
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

alias libcxx-lit='./libcxx/utils/libcxx-lit'

################################################################################
# Environment variables
################################################################################
export PATH="${HOME}/.bin:${PATH}"
if which code &>/dev/null; then
    export EDITOR="$(which code) --wait"
fi
PROMPT='%n in %~ %# '

# Keep the zsh history under ~/Documents, which is synchronized across
# devices on macOS.
export HISTFILE=${HOME}/Documents/.zsh_history

export HISTSIZE=10000000         # Maximum number of history lines kept per session
export SAVEHIST=10000000         # Maximum number of history lines kept across all sessions
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.

# Make sure we find Rust programs installed with cargo
export PATH="${PATH}:${HOME}/.cargo/bin"

################################################################################
# Initialize integrations
################################################################################
if [[ "$(uname -m)" == "arm64" ]]; then
    # On ARM macOS, brew is installed in /opt/homebrew
    _brew_prefix="/opt/homebrew"
else
    # On Intel macOS, brew is installed in /usr/local
    _brew_prefix="/usr/local"
fi

# Set PATH, MANPATH, etc., for Homebrew.
eval "$(${_brew_prefix}/bin/brew shellenv)"

# rbenv
if command -v rbenv &>/dev/null; then
    eval "$(rbenv init -)"
fi

# iTerm2
if [[ -f "${HOME}/.iterm2_shell_integration.zsh" ]]; then
    source "${HOME}/.iterm2_shell_integration.zsh"
fi

# zsh autocompletion
autoload -Uz compinit && compinit

# fzf key bindings
if [[ ! "$PATH" == *${_brew_prefix}/opt/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}${_brew_prefix}/opt/fzf/bin"
fi
eval "$(fzf --zsh)"

################################################################################
# Miscellaneous
################################################################################
# Load any private configurations that I don't want to push to GitHub
if [[ -f "${HOME}/.zshrc.private" ]]; then
    source "${HOME}/.zshrc.private"
fi

# Function to download WG21 papers
function download-paper() {
    paper="${1}"
    url="$(curl --silent "https://wg21.link/${paper}" | cut -f 4 -d ' ')"
    wget "${url}"
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

# Run clang-format on the files that were changed by the last git commit.
function clang-format-changed() {
    for file in $(git diff --name-only HEAD~); do
        file="${PWD}/${file}"
        dir="$(dirname "${file}")"
        (cd "${dir}" && clang-format -i "${file}")
    done
}
