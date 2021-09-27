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

# mosh
alias mmosh "mosh main -- tmux a"

# golang
alias gowtf "go clean -cache -modcache -i -r"

# git utilities
alias commit-types "cat $HOME/.config/git/commit-types"
alias ct "cat $HOME/.config/git/commit-types"

source /opt/homebrew/opt/asdf/asdf.fish

fish_add_path /opt/homebrew/bin
