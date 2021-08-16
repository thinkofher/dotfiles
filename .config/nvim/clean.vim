" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin(stdpath('data') . '/plugged')

" Write your .vimrc in Lua!
Plug 'svermeulen/vimpeccable'

" A Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-fugitive'

" Colorschemes
Plug 'nanotech/jellybeans.vim'

" Plugin that provides Rust file detection, syntax highlighting,
" formatting, etc.
Plug 'rust-lang/rust.vim'

" fzf stands for “fuzzy finder” and works similarly to the Goto
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Plugin for haskell syntax
Plug 'neovimhaskell/haskell-vim'

" Built-in lsp
Plug 'neovim/nvim-lspconfig'

" Plugin for elm syntax
Plug 'ElmCast/elm-vim'

" Shows which lines have been added, modified, or removed
Plug 'mhinz/vim-signify'

" For lisp development
Plug 'junegunn/rainbow_parentheses.vim'

" Editing gpg files
Plug 'jamessan/vim-gnupg'

" Janet programming language support
Plug 'bakpakin/janet.vim'

" Elixir programming language support
Plug 'elixir-editors/vim-elixir'

call plug#end()

" Load init lua file
lua require('thinkofher.init')
lua require('thinkofher.clean')
