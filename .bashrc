# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

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

export EDITOR=$CLEAN_VIM

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# pyenv
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
