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

# homebrew zsh functions
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

# autocompletion settings
zstyle ':completion:*' menu select
zstyle ':completion:ls:*' menu yes select
zstyle ':completion:*:default' list-colors \
    "di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"

autoload -Uz compinit
compinit

# user specific zsh functions
fpath+=$HOME/.local/share/zsh/site-functions

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=
export CLEAN_VIM="nvim -u $HOME/.config/nvim/clean.vim"

# user specific aliases and functions
alias v=$CLEAN_VIM
alias vi=nvim
alias vim=nvim

# ls aliases
alias ll="ls -lh"
alias la="ls -alh"

# mosh
alias mosh="LC_ALL=en_GB.UTF-8 mosh"
alias mmosh="mosn main -- tmux a"

# notes
alias notes="vim $HOME/Documents/notes.md"

# age
alias agei="age -i $HOME/.config/age/keys.age"
alias agep="age -R $HOME/.config/age/keys.pub"

# editor & manpager
export EDITOR=$CLEAN_VIM
export MANPAGER="nvim -c 'set ft=man' -"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# zsh prompt
[ -f ~/.zshrc.prompt ] && source ~/.zshrc.prompt

# asdf
. /opt/homebrew/opt/asdf/asdf.sh

function cheat() { # display cheat sheet for given topic
    curl -sL cheat.sh/$1 | less -r
}
