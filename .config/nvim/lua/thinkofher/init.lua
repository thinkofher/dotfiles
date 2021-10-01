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

vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }

-- Change the "hint" color to the "orange" color, and make the "error" color bright red
vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }

-- Load the colorscheme
utils.colorscheme('tokyonight')

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

-- < GOLANG >

-- golang auto command
auto.cmd('FileType go', function()
    cmd([[set list listchars=tab:\ \ ]])

    vim.bo.expandtab = false
    vim.o.expandtab = false

    utils.indentn(4)
end)

auto.cmd('BufNewFile,BufRead *.mod', function()
    cmd([[set list listchars=tab:\ \ ]])

    vim.bo.expandtab = false
    vim.o.expandtab = false

    utils.indentn(4)
end)

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

-- < YAML >
auto.cmd('FileType yaml', function()
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

-- < VIM-GO >
vim.g.go_fmt_command = "goimports"
vim.g.go_fmt_autosave = 1
vim.g.go_fmt_fail_silently = 1
vim.g.go_asmfmt_autosave = 1
vim.g.go_autodetect_gopath = 1
vim.g.go_list_type = "quickfix"

vim.g.go_highlight_types = 1
vim.g.go_highlight_fields = 1
vim.g.go_highlight_functions = 1
vim.g.go_highlight_function_calls = 1
vim.g.go_highlight_extra_types = 1
vim.g.go_highlight_generate_tags = 1
vim.g.go_highlight_operators = 1
vim.g.go_echo_go_info = 0
vim.g.go_auto_type_info = 1
vim.g.go_metalinter_autosave_enabled = {'vet', 'golint', 'errcheck'}
