# .zshrc

# PS1
export PS1='%(?.%(!.#.;).%F{6}%B;%b%f) '

# autocompletion settings
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:ls:*' menu yes select
zstyle ':completion:*:default' list-colors \
    "di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"

# enable colorful output of ls
export CLICOLOR=1

# set language
export LANG="en_GB.UTF-8"

# homebrew zsh functions
fpath+=/opt/homebrew/share/zsh/site-functions

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

export CLEAN_VIM="nvim -u $HOME/.config/nvim/clean.vim"

# User specific aliases and functions
alias v=$CLEAN_VIM
alias vi=nvim
alias vim=nvim
alias mmosh="mosn main -- tmux a"

export EDITOR=$CLEAN_VIM
export MANPAGER="nvim -c 'set ft=man' -"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# pyenv
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi
