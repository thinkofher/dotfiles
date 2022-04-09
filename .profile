# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# RUST
# export PATH=$HOME/.cargo/bin:$PATH

# GOLANG
# export GOPATH=$HOME/go
# export GOROOT=/usr/local/go
# export PATH=$GOROOT/bin:$PATH
# export PATH=$GOPATH/bin:$PATH

# PYENV
# export PYENV_ROOT=$HOME/.pyenv
# export PATH=$PYENV_ROOT/bin:$PATH

# NPM
# export PATH=$HOME/.local/node_modules/bin:$PATH

# CABAL
# export PATH=$HOME/.cabal/bin:$PATH

# DOTNET
# export PATH=$HOME/.dotnet/tools:$PATH

# DENO
# export DENO_INSTALL="/home/beniamin/.deno"
# export PATH="$DENO_INSTALL/bin:$PATH"
