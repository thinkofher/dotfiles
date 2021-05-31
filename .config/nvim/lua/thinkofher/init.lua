local cmd = vim.cmd
local api = vim.api

local vimp = require('vimp')
local lspc = require('lspconfig')
local lsp = vim.lsp
local set = api.nvim_set_option

-- local lua plugins
local auto = require('thinkofher.auto')
local utils = require('thinkofher.utils')

-- BASICS
-- ======
set('compatible', false)
cmd('filetype plugin on')
cmd('filetype plugin indent on')

-- FINDING FILES
-- =============
cmd('set path+=**')
set('wildmenu', true)

-- THEMES
-- ======
cmd('syntax enable')
cmd('colorscheme jellybeans')

-- OVERALL SETTINGS
-- ================

-- encoding
vim.o.encoding = 'utf-8'

-- required for operations modifying multiple buffers like rename
vim.o.hidden = true

-- spaces & Tabs
utils.indentn(4)

vim.o.expandtab = true -- tabs are spaces
vim.bo.expandtab = true

vim.o.autoindent = true
vim.bo.autoindent = true

vim.o.copyindent = true -- copy indent from the previous line
vim.bo.copyindent = true

-- searching files
vim.o.incsearch = true
vim.o.ignorecase = true

-- always show statusline
vim.o.laststatus = 2

-- autocompletion
cmd('set completeopt-=preview')
set('omnifunc', 'syntaxcomplete#Complete')

-- backup functionalities
set('undofile', true)

-- don't wrap lines
vim.wo.wrap = false

cmd([[set list listchars=trail:.,extends:>]])

-- LANGUAGE SPECIFIC SETTINGS AND LSP
-- ==================================

-- lsp settings for every supported lang
auto.cmd('FileType c,cpp,rust', utils.setup_lsp)

-- < WEB DEV >

-- web dev auto command
auto.cmd('FileType javascript,html,css', function()
    utils.indentn(2)
end)

-- set tpl file type to html
auto.cmd('BufNewFile,BufRead *.tpl', function()
    cmd('set filetype=html')
end)

-- < C, CPP >
lspc.clangd.setup({})

-- c, cpp auto command
auto.cmd('FileType c,cpp', function()

    cmd([[set list listchars=tab:\ \ ]])
    cmd([[setlocal omnifunc=v:lua.vim.lsp.omnifunc]])
    utils.indentn(2)
end)

-- clang-format after save
auto.cmd('BufWritePost *.c,*.cpp,*.h,*.hpp', function()
    utils.silent('!clang-format -i %')
    utils.silent('edit')
end)

-- < RUST >
lspc.rust_analyzer.setup({})

-- rust auto command
auto.cmd('FileType rust', function()
    cmd([[setlocal omnifunc=v:lua.vim.lsp.omnifunc]])
end)

-- < RACKET >

-- lisp auto command
auto.cmd('FileType lisp,racket,scheme', function()
    utils.indentn(2)
    cmd('RainbowParentheses')
end)

-- < HASKELL >
-- requirement: hasktags

-- haskell auto command
auto.cmd('FileType haskell', function()
    -- generate ctags after save
    auto.cmd('BufWritePost *', function()
        utils.silent('!hasktags --ctags.')
    end)

    cmd([[set list listchars=eol:¬]])
    utils.indentn(2)
end)

-- < PROTO >
auto.cmd('FileType proto', function()
    utils.indentn(2)
end)

-- MAPPINGS
-- ========
vim.g.mapleader = '>'

-- mappings for moving lines
vimp.nnoremap('<A-j>', [[:m .+1<CR>==]])
vimp.nnoremap('<A-k>', [[:m .-2<CR>==]])
vimp.inoremap('<A-j>', [[<Esc>:m .+1<CR>==gi]])
vimp.inoremap('<A-k>', [[<Esc>:m .-2<CR>==gi]])
vimp.vnoremap('<A-j>', [[:m '>+1<CR>gv=gv]])
vimp.vnoremap('<A-k>', [[:m '<-2<CR>gv=gv]])

-- terminal settings
vimp.nnoremap('<leader>t', ':tabnew<CR>:terminal<CR>')
vimp.tnoremap('<ESC>', [[<C-\><C-n>]])

-- PLUGINS SETTINGS
-- ================

-- < SIGNIFY >
vim.o.updatetime = 100

-- < FZF >
vim.env.FZF_DEFAULT_COMMAND = 'ag --hidden -l -g ""'
vim.g.fzf_layout = {
    down = '25%'
}

-- Ctrl+P command
vimp.nnoremap({'silent'}, '<c-p>', function()
    utils.silent('Files')
end)

-- < NETRW >
-- Tweaks for browsing
vim.g.netrw_banner = 0  -- disable annoying banner
vim.g.netrw_altv = 1  -- open splits to the right
vim.g.netrw_liststyle = 3  -- tree view
vim.g.netrw_list_hide = [[,\(^\|\s\s\)\zs\.\S\+]]
