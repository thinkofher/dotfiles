" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin(stdpath('data') . '/plugged')
" Make sure you use single quotes

" Built-in lsp for neovim
Plug 'neovim/nvim-lspconfig'

" Asynchronous linting and make framework for Neovim/Vim
Plug 'neomake/neomake'

" Vim code formatter plugin
Plug 'sbdchd/neoformat'

" Insert or delete brackets, parens, quotes in pair
Plug 'jiangmiao/auto-pairs'

" A Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-fugitive'

" Colorschemes
Plug 'nanotech/jellybeans.vim'

" Nerdtree
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" fzf stands for “fuzzy finder” and works similarly to the Goto
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Shows which lines have been added, modified, or removed
Plug 'mhinz/vim-signify'

" The plugin provides mappings to easily delete, change and add such surroundings in pairs
Plug 'tpope/vim-surround'

" plugin that provides Rust file detection, syntax highlighting, formatting
" etc..
Plug 'rust-lang/rust.vim'

" Golang plugins
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Emmet plugin
Plug 'mattn/emmet-vim'

" Vim comments plugin
Plug 'tpope/vim-commentary'

" Nerd font icons
Plug 'ryanoasis/vim-devicons'

" Clojure plugins
Plug 'Olical/conjure', {'tag': 'v4.9.0'}
Plug 'junegunn/rainbow_parentheses.vim'

" For racket development
Plug 'wlangstroth/vim-racket'

" For elixir development
Plug 'elixir-editors/vim-elixir'

" Deoplete
Plug 'Shougo/deoplete.nvim'

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

" LANGUAGE SPECIFIC SETTINGS AND LSP
" ----------------------------------
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>

" < HASKELL >
autocmd FileType haskell set list listchars=eol:¬

" < C, CPP >
autocmd FileType c,cpp,make set list listchars=eol:¬,tab:\|\ 
autocmd FileType c,cpp,make set noexpandtab

" < RUST >
lua require'lspconfig'.rust_analyzer.setup{}
autocmd FileType rust set list listchars=eol:¬
autocmd Filetype rust setlocal omnifunc=v:lua.vim.lsp.omnifunc

" < PYTHON >
lua require'lspconfig'.pyls.setup{}
autocmd Filetype python setlocal omnifunc=v:lua.vim.lsp.omnifunc

" < ELIXIR >
lua << EOF
require'lspconfig'.elixirls.setup{
    cmd = { "/home/beniamin/.local/bin/elixirlsp/language_server.sh" };
}
EOF
autocmd Filetype elixir setlocal omnifunc=v:lua.vim.lsp.omnifunc

" < WEB DEV >
autocmd FileType javascript,html,css set tabstop=2
autocmd FileType javascript,html,css set softtabstop=2
autocmd FileType javascript,html,css set shiftwidth=2

" < GOLANG >
lua require'lspconfig'.gopls.setup{}
autocmd Filetype go setlocal omnifunc=v:lua.vim.lsp.omnifunc

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

" < NEOMAKE >
" when writing a buffer (no delay).
call neomake#configure#automake('w')
" when writing a buffer (no delay), and on normal mode changes (after 750ms).
call neomake#configure#automake('nw', 750)
" When reading a buffer (after 1s), and when writing (no delay).
call neomake#configure#automake('rw', 1000)
" full config: when writing or reading a buffer, and on changes in insert and
" normal mode (after 1s; no delay when writing).
call neomake#configure#automake('nrwi', 500)

" rust config for neomake
let g:neomake_rust_cargo_command = ['test', '--no-run']

" < SIGNIFY >
set updatetime=100

" < FZF >
let $FZF_DEFAULT_COMMAND = 'ag --hidden -l -g ""'

" < NERDTREE >
map <C-p> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let NERDTreeIgnore = ['\.pyc$', '__pycache__']

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

" < CONJURE >
let g:conjure_log_direction = "horizontal"
let g:conjure_log_blacklist = ["up", "ret", "ret-multiline", "load-file", "eval"]
nnoremap gcj :ConjureEval<CR>

augroup rainbow_lisp
  autocmd!
  autocmd FileType lisp,clojure,scheme,racket RainbowParentheses
augroup END

let g:deoplete#enable_at_startup = 1
