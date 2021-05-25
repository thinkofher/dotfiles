" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin(stdpath('data') . '/plugged')
" Make sure you use single quotes

" Write your .vimrc in Lua!
Plug 'svermeulen/vimpeccable'

" Built-in lsp for neovim
Plug 'neovim/nvim-lspconfig'

" Vim code formatter plugin
Plug 'sbdchd/neoformat'

" Insert or delete brackets, parens, quotes in pair
Plug 'jiangmiao/auto-pairs'

" Colorschemes
Plug 'nanotech/jellybeans.vim'

" fzf stands for “fuzzy finder” and works similarly to the Goto
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Shows which lines have been added, modified, or removed
Plug 'mhinz/vim-signify'

" The plugin provides mappings to easily delete, change and add such surroundings in pairs
Plug 'tpope/vim-surround'

" A Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-fugitive'

" Vim comments plugin
Plug 'tpope/vim-commentary'

" plugin that provides Rust file detection, syntax highlighting, formatting
" etc..
Plug 'rust-lang/rust.vim'

" Golang plugins
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Emmet plugin
Plug 'mattn/emmet-vim'

" For racket development
Plug 'wlangstroth/vim-racket'
Plug 'junegunn/rainbow_parentheses.vim'

" Initialize plugin system
call plug#end()

" LUA CONFIG FILES
" ----------------
lua require('thinkofher.init')
lua require('thinkofher.ide')
