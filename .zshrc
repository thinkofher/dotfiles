# .zshrc

# key mappings
bindkey -v
export KEYTIMEOUT=1

# allow comments in interactive mode
setopt interactivecomments

# PS1
export PS1='%(?.%(!.#.;).%F{6}%B;%b%f) '

# enable colorful output of ls
export CLICOLOR=1

# set language
export LANG="en_GB.UTF-8"

# autocompletion settings
zstyle ':completion:*' menu select
zstyle ':completion:ls:*' menu yes select
zstyle ':completion:*:default' list-colors \
    "di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"

autoload -Uz compinit
compinit

# user specific zsh functions
fpath+=$HOME/.local/share/zsh/site-functions

# nix zsh site functions
fpath+=$HOME/.nix-profile/share/zsh/site-functions

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# aliases
[ -f ~/.zshrc.aliases ] && source ~/.zshrc.aliases

# zsh prompt
[ -f ~/.zshrc.prompt ] && source ~/.zshrc.prompt

# additional zsh shell functions
[ -f ~/.zshrc.funcs ] && source ~/.zshrc.funcs

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.nix-profile/share/fzf/key-bindings.zsh ] && source ~/.nix-profile/share/fzf/key-bindings.zsh
[ -f ~/.nix-profile/share/fzf/completion.zsh ] && source ~/.nix-profile/share/fzf/completion.zsh

# cargo
[ -f ~/.cargo/env ] && source ~/.cargo/env

# editor & manpager
export EDITOR=$CLEAN_VIM

# colored man pager
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'
