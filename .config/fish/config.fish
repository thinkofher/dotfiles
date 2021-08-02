# Fish Shell config file ><>
# author: Beniamin Dudek <beniamin.dudek@yahoo.com>
#
# Most of the stuff here is commented out, because it slows down
# startup of the shell. I am using fish as the interactive shell, at
# top of the bash, so i don't have to hustle with all the ENV variables.


# fisher bootstrap
# uncomment it to install fisher (fish plugin manager) and the startup

# if not functions -q fisher
#     set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
#     curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
#     fish -c fisher
# end

# neovim aliases
alias v "nvim -u ~/.config/nvim/clean.vim"
alias e v
alias vi nvim
alias vim nvim
alias mmosh "mosh main -- tmux a"
alias gowtf "go clean -cache -modcache -i -r"

# path
# set -Ua fish_user_paths $HOME/.local/bin

# go
# set GOPATH $HOME/go
# set GOROOT /usr/loca/go
# set -Ua fish_user_paths $GOROOT/bin
# set -Ua fish_user_paths $GOPATH/bin

# npm
# set -Ua fish_user_paths $HOME/.local/node_modules/bin

# rust
# set -Ua fish_user_paths $HOME/.cargo/bin

# cabal
# set -Ua fish_user_paths $HOME/.cabal/bin

# pyenv
# set PYENV_ROOT $HOME/.pyenv
# set PATH $PYENV_ROOT/bin $PATH
# status --is-interactive; and source (pyenv init -|psub)
# status --is-interactive; and source (pyenv virtualenv-init -|psub)

# fzf
# set -Ua fish_user_paths $HOME/.fzf/bin

source /opt/homebrew/opt/asdf/asdf.fish
