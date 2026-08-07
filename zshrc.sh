# Zsh
PROMPT="%F{green}%n@%m%f %~ $ "
HISTFILE=~/.zshhist             # Save history file
HISTSIZE=10000                  # Save history zsh max lines
SAVEHIST=10000                  # Save history file max lines

source $ZSH/oh-my-zsh.sh

setopt autocd appendhistory sharehistory incappendhistory hist_ignore_dups
unsetopt beep notify               # No bells >:C !
bindkey -v                        # Use VI Keybindings
bindkey '^[[1;5D' backward-word   # Ctrl + Left
bindkey '^[[1;5C' forward-word    # Ctrl + Right
bindkey '^[[1;5A' up-line-or-history
bindkey '^[[1;5B' down-line-or-history

source <(fzf --zsh) # CTRL + R for fuzzy history finder

ZSH="$HOME/.oh-my-zsh"
export ZSH
plugins=(
    git
    sudo
    web-search
    archlinux
    zsh-autosuggestions
    fast-syntax-highlighting
    copyfile
    copybuffer
    dirhistory
)


# Exports
LC_ALL="C"
export LC_ALL;

CC="/usr/bin/clang"
export CC

CXX="/usr/bin/clang++"
export CXX

GPG_TTY=$(tty)
export GPG_TTY

EDITOR="$(which nvim)"
export EDITOR

# Path
PNPM_HOME="/home/light/.local/share/pnpm"
export PNPM_HOME
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

PATH="${PATH}:/home/light/.local/bin"
export PATH

# Aliases
alias v='nvim'
alias icat='kitty +kitten icat'
alias cat='bat'
alias zsrc='source ~/.zshrc'
alias q='exit'
alias l='\eza --icons --sort type -TL1'
alias la='\eza --icons --sort type -T1' # all
alias ~="c ~"
alias ..='c ../'
alias ...='c ../../'
alias ....='c ../../../'
alias .....='c ../../../../'
alias ......='c ../../../../../'
alias rylai='ssh rylai'

c  () { cd ${1:-.} ; clear ; l          }
ca () { cd ${1:-.} ; clear ; la         }
cn () { cd ${1:-.} ; clear ; hyfetch    }
cgs() { cd ${1:-.} ; clear ; git status }

cn
