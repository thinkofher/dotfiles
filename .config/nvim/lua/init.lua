local cmd = vim.cmd
local api = vim.api

local auto = require('auto')
local lsp = require('lspconfig')
local set = api.nvim_set_option

-- HELPERS
-- =======

-- silent runs given vim command silently
function silent(command)
    cmd('silent' .. ' ' .. command)
end

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
vim.o.tabstop = 4 -- number of visual spaces per TAB
vim.bo.tabstop = 4

vim.o.softtabstop = 4 -- number of spaces in tab when editing
vim.bo.softtabstop = 4

vim.o.shiftwidth = 4 -- number of spaces to use for autoindent
vim.bo.shiftwidth = 4

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
set('undodir', '~/.local/share/nvim/undodir')

-- don't wrap lines
vim.wo.wrap = false

cmd([[set list listchars=trail:.,extends:>]])

-- LANGUAGE SPECIFIC SETTINGS AND LSP
-- =================================

-- < GOLANG >
lsp.gopls.setup({})

-- golang auto command
auto.cmd("FileType go", function()
        cmd([[set list listchars=tab:\ \ ]])
        cmd([[setlocal omnifunc=v:lua.vim.lsp.omnifunc]])
        vim.bo.expandtab = false
        vim.o.expandtab = false
        vim.bo.tabstop = 4
        vim.o.tabstop = 4
        vim.bo.softtabstop = 4
        vim.o.softtabstop = 4
end)

-- go fmt after save
auto.cmd("BufWritePost *.go", function()
        silent('!gofmt -w %')
        silent('!goimports -w %')
        silent('edit')
end)
