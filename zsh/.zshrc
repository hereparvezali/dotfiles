HISTFILE=~/.cache/histfile
HISTSIZE=10000
SAVEHIST=10000

setopt autocd beep extendedglob nomatch notify share_history hist_ignore_dups hist_save_no_dups hist_ignore_space inc_append_history

fpath=(~/.local/share/zsh/completions $fpath)
autoload -Uz compinit
compinit

eval "$(zoxide init zsh)"


bindkey -e
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line


ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats '(%b)'
precmd() { vcs_info }
PROMPT='%F{#aaaaaa}%~%f %F{#dddddd}${vcs_info_msg_0_}%f%F{green}%B>%b%f '


zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
# zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

alias cd='z'
alias ls='ls --color=auto'

export PATH="$PATH:$HOME/.cargo/bin"
