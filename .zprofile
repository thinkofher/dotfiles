# Homebrew package manager
eval "$(/opt/homebrew/bin/brew shellenv)"

# XCode command line tools binaries
export PATH="$PATH:/Library/Developer/CommandLineTools/usr/bin"

# Golang
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

# Deno
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# Ruby
export PATH="$HOME/.asdf/shims:$PATH"

# Deta dev tools
export PATH="/Users/bdudek/.deta/bin:$PATH"
