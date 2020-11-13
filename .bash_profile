# .bash_profile

if [ -f ~/.secret/.bashsecret ]; then
    . ~/.secret/.bashsecret
fi

# User specific environment and startup programs

# RUST
export PATH=$HOME/.cargo/bin:$PATH

# GOLANG
export GOPATH=$HOME/go
export GOROOT=/usr/local/go
export PATH=$GOROOT/bin:$PATH
export PATH=$GOPATH/bin:$PATH

# PYENV
export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/bin:$PATH

# NPM
export PATH=$HOME/.local/node_modules/bin:$PATH

# CABAL
export PATH=$HOME/.cabal/bin:$PATH

# DOTNET
export PATH=$HOME/.dotnet/tools:$PATH

# DENO
export DENO_INSTALL="/home/beniamin/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi
