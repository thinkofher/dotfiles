# Fish Shell config file ><>
# author: Beniamin Dudek <beniamin.dudek@yahoo.com>
#
# Most of the stuff here is commented out, because it slows down
# startup of the shell. I am using fish as the interactive shell, at
# top of the bash, so i don't have to hustle with all the ENV variables.

# neovim aliases
alias v "nvim -u NONE"
alias e v
alias vi nvim
alias vim nvim

# golang
alias gowtf "go clean -cache -modcache -i -r"

# git utilities
alias commit-types "cat $HOME/.config/git/commit-types"
alias ct "cat $HOME/.config/git/commit-types"
