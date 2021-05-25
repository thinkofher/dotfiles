local cmd = vim.cmd
local api = vim.api

local auto = require('auto')
local lsp = vim.lsp
local lspc = require('lspconfig')
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

-- indentn sets tabstop, softtabstop and shiftwidth
-- to given number
function indentn(number)
    vim.o.tabstop = number -- number of visual spaces per TAB
    vim.bo.tabstop = number

    vim.o.softtabstop = number -- number of spaces in tab when editing
    vim.bo.softtabstop = number

    vim.o.shiftwidth = number -- number of spaces to use for autoindent
    vim.bo.shiftwidth = number
end

-- spaces & Tabs
indentn(4)

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
-- ==================================

-- lsp settings for every supported lang
auto.cmd('FileType c,cpp,go,rust', function()
    -- nmap is local helper function for silent nnoremap
    local nmap = function(lhs, rhs)
        vimp.nnoremap({'silent'}, lhs, rhs)
    end

    nmap('gd', lsp.buf.declaration)
    nmap('<c-]>', lsp.buf.definition)
    nmap('K', lsp.buf.hover)
    nmap('gD', lsp.buf.implementation)
    nmap('<c-k>', lsp.buf.implementation)
    nmap('<c-k>', lsp.buf.signature_help)
    nmap('1gD', lsp.buf.type_definition)
    nmap('gr', lsp.buf.references)
    nmap('g0', lsp.buf.document_symbol)
    nmap('gW', lsp.buf.workspace_symbol)
    nmap('glf', lsp.buf.formatting)
end)


-- < WEB DEV >

-- web dev auto command
auto.cmd("FileType javascript,html,css", function()
    indentn(2)
end)

-- set tpl file type to html
auto.cmd('BufNewFile,BufRead *.tpl', function()
    cmd('set filetype=html')
end)

-- < C, CPP >
lspc.clangd.setup({})

-- c, cpp auto command
auto.cmd("FileType c,cpp", function()
    -- clang-format after save
    auto.cmd("BufWritePost *", function()
        silent('!clang-format -i %')
        silent('edit')
    end)

    cmd([[set list listchars=tab:\ \ ]])
    cmd([[setlocal omnifunc=v:lua.vim.lsp.omnifunc]])
    indentn(2)
end)

-- < GOLANG >
lspc.gopls.setup({})

-- golang auto command
auto.cmd("FileType go", function()
    cmd([[set list listchars=tab:\ \ ]])
    cmd([[setlocal omnifunc=v:lua.vim.lsp.omnifunc]])
    vim.bo.expandtab = false
    vim.o.expandtab = false
    indentn(4)

    -- go fmt after save
    auto.cmd("BufWritePost *", function()
        silent('!gofmt -w %')
        silent('!goimports -w %')
        silent('edit')
    end)
end)

-- < RUST >
lspc.rust_analyzer.setup({})

-- rust auto command
auto.cmd("FileType rust", function()
    cmd([[setlocal omnifunc=v:lua.vim.lsp.omnifunc]])
end)

-- < RACKET >

-- lisp auto command
auto.cmd("FileType lisp,racket,scheme", function()
    indentn(2)
    cmd('RainbowParentheses')
end)

-- < HASKELL >
-- requirement: hasktags

-- haskell auto command
auto.cmd("FileType haskell", function()
    -- generate ctags after save
    auto.cmd('BufWritePost *', function()
        silent('!hasktags --ctags.')
    end)

    cmd([[set list listchars=eol:¬]])
    indentn(2)
end)
