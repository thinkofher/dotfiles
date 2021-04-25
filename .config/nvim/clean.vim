" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin(stdpath('data') . '/plugged')
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

call plug#end()

" BASICS
" ------
set nocompatible
filetype plugin on
filetype plugin indent on

" FINDING FILES
" -------------
set path+=**
set wildmenu

" THEMES
" ------
syntax enable
colorscheme jellybeans

" OVERALL SETTINGS
" ----------------

" encoding
set encoding=UTF-8

" required for operations modifying multiple buffers like rename
set hidden

" spaces & Tabs
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set expandtab       " tabs are space
set autoindent
set copyindent      " copy indent from the previous line

" searching files
set incsearch
set ignorecase

" always show statusline
set laststatus=2

" autocompletion
set completeopt-=preview
set omnifunc=syntaxcomplete#Complete

" backup functionalities
set undofile
set undodir="~/.local/share/nvim/undodir"

" removes trailing spaces
function TrimWhiteSpace()
    %s/\s*$//
    ''
endfunction
set list listchars=trail:.,extends:>

" < WEB DEV >
autocmd FileType javascript,html,css set tabstop=2
autocmd FileType javascript,html,css set softtabstop=2
autocmd FileType javascript,html,css set shiftwidth=2
autocmd BufNewFile,BufRead *.tpl set filetype=html

" < PYTHON >
let g:pyindent_open_paren = 'shiftwidth()'
let g:pyindent_nested_paren = 'shiftwidth()'
let g:pyindent_continue = 'shiftwidth() * 2'

" < HASKELL >

" requirement: hasktags
autocmd FileType haskell set list listchars=eol:¬
autocmd FileType haskell autocmd BufWritePost * silent !hasktags --ctags .
autocmd FileType haskell set tabstop=2
autocmd FileType haskell set softtabstop=2
autocmd FileType haskell set shiftwidth=2

" < C, CPP >
autocmd FileType c,cpp set tabstop=2
autocmd FileType c,cpp set softtabstop=2
autocmd FileType c,cpp set shiftwidth=2

" < RUST >
autocmd FileType rust set list listchars=eol:¬

" < GOLANG >

function GoFmt()
    !gofmt -w %
    !goimports -w %
    edit
endfunction
autocmd BufWritePost *.go silent call GoFmt()

" autocmd BufNewFile,BufRead *.mod set list listchars=eol:¬,tab:\|\ 
autocmd BufNewFile,BufRead *.mod set list listchars=tab:\|\ 
autocmd BufNewFile,BufRead *.mod set noexpandtab
autocmd BufNewFile,BufRead *.mod set tabstop=4
autocmd BufNewFile,BufRead *.mod set softtabstop=4
autocmd BufNewFile,BufRead *.mod set shiftwidth=4

" autocmd FileType go set list listchars=eol:¬,tab:\|\ 
autocmd FileType go set list listchars=tab:\|\ 
autocmd FileType go set noexpandtab
autocmd FileType go set tabstop=4
autocmd FileType go set softtabstop=4
autocmd FileType go set shiftwidth=4

" < RACKET >
autocmd FileType lisp,racket,scheme set tabstop=2
autocmd FileType lisp,racket,scheme set softtabstop=2
autocmd FileType lisp,racket,scheme set shiftwidth=2

augroup rainbow_lisp
  autocmd!
  autocmd FileType racket,lisp,clojure,scheme RainbowParentheses
augroup END

" NEOVIM PYTHON SPECIFIC ENVIRONMENT
" ----------------------------------

" You should isolate python packages for neovim
" from local python ENVIRONMENT.
" You can accomplish that with pyenv.
let g:python3_host_prog = '/home/beniamin/.pyenv/versions/neovim/bin/python'

" MAPPINGS
" --------

" mappings for moving lines
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" terminal settings
nnoremap <leader>t :tabnew<CR>:terminal<CR>
tnoremap <ESC> <C-\><C-n>

" PLUGINS SETTINGS
" ----------------

" Tweaks for browsing
let g:netrw_banner=0        " disable annoying banner
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" < FZF >
let $FZF_DEFAULT_COMMAND = 'ag --hidden -l -g ""'
let g:fzf_layout = { 'down': '25%' }

" Ctrl+P command
nnoremap <silent> <c-p> <cmd>Files<CR>
