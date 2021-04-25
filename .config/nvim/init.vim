" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin(stdpath('data') . '/plugged')
" Make sure you use single quotes

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

" Clojure plugins
Plug 'Olical/conjure', {'tag': 'v4.9.0'}
Plug 'junegunn/rainbow_parentheses.vim'

" For racket development
Plug 'wlangstroth/vim-racket'

" For elixir development
Plug 'elixir-editors/vim-elixir'

" Initialize plugin system
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
set background=dark
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

" column
set colorcolumn=80

" backup functionalities
set undofile
set undodir="~/.local/share/nvim/undodir"

" removes trailing spaces
function TrimWhiteSpace()
    %s/\s*$//
    ''
endfunction
set list listchars=trail:.,extends:>


" < HASKELL >
autocmd FileType haskell set list listchars=eol:¬

" < C, CPP >
autocmd FileType c,cpp,make set list listchars=eol:¬,tab:\|\ 
autocmd FileType c,cpp,make set noexpandtab

" < RUST >
autocmd FileType rust set list listchars=eol:¬

" < WEB DEV >
autocmd FileType javascript,html,css set tabstop=2
autocmd FileType javascript,html,css set softtabstop=2
autocmd FileType javascript,html,css set shiftwidth=2

" < PROTO >
autocmd FileType proto set tabstop=2
autocmd FileType proto set softtabstop=2
autocmd FileType proto set shiftwidth=2

" autocmd BufNewFile,BufRead *.mod set list listchars=eol:¬,tab:\|\ 
autocmd BufNewFile,BufRead *.mod set list listchars=tab:\|\ 
autocmd BufNewFile,BufRead *.mod set noexpandtab
autocmd BufNewFile,BufRead *.mod set tabstop=4
autocmd BufNewFile,BufRead *.mod set softtabstop=4
autocmd BufNewFile,BufRead *.mod set shiftwidth=4

" autocmd FileType go set list listchars=eol:¬,tab:\|\ 
autocmd FileType go set list listchars=tab:\ \ 
autocmd FileType go set noexpandtab
autocmd FileType go set tabstop=4
autocmd FileType go set softtabstop=4
autocmd FileType go set shiftwidth=4

" < RACKET >
autocmd FileType lisp,racket,scheme set tabstop=2
autocmd FileType lisp,racket,scheme set softtabstop=2
autocmd FileType lisp,racket,scheme set shiftwidth=2

" < YAML >
autocmd FileType yaml set tabstop=2
autocmd FileType yaml set softtabstop=2
autocmd FileType yaml set shiftwidth=2


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

" silently saving file
nnoremap <silent><leader><leader> :silent w<CR>

" mappings for go and vim-go plugin
nnoremap <leader>gg :only<CR>:silent w<CR>:GoRun<CR>
nnoremap <leader>gw :GoInstall<CR>:silent w<CR>
nnoremap <leader>gd :GoDef<CR>

" terminal settings
nnoremap <leader>t :tabnew<CR>:terminal<CR>
tnoremap <ESC> <C-\><C-n>


" PLUGINS SETTINGS
" ----------------

" < SIGNIFY >
set updatetime=100

" < FZF >
let $FZF_DEFAULT_COMMAND = 'ag --hidden -l -g ""'
let g:fzf_layout = { 'down': '25%' }

" Ctrl+P command
nnoremap <silent> <c-p> <cmd>Files<CR>

" < NETRW >
let g:netrw_banner=0        " disable annoying banner
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" < TAGBAR >
nmap <F8> :TagbarToggle<CR>

" < VIM-GO >
let g:go_fmt_command = "goimports"
let g:go_fmt_autosave = 1
let g:go_fmt_fail_silently = 1
let g:go_asmfmt_autosave = 1
let g:go_autodetect_gopath = 1
let g:go_list_type = "quickfix"

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_operators = 1
let g:go_echo_go_info = 0
let g:go_auto_type_info = 1
let g:go_metalinter_autosave_enabled = ['vet', 'golint', 'errcheck']

" < CONJURE >
let g:conjure_log_direction = "horizontal"
let g:conjure_log_blacklist = ["up", "ret", "ret-multiline", "load-file", "eval"]
nnoremap gcj :ConjureEval<CR>

augroup rainbow_lisp
  autocmd!
  autocmd FileType lisp,clojure,scheme,racket RainbowParentheses
augroup END
