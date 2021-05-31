local cmd = vim.cmd
local api = vim.api

local vimp = require('vimp')
local lspc = require('lspconfig')
local lsp = vim.lsp

-- local lua plugins
local auto = require('thinkofher.auto')
local utils = require('thinkofher.utils')

-- LANGUAGE SPECIFIC SETTINGS AND LSP
-- ==================================

-- lsp settings for every supported lang
auto.cmd('FileType go', utils.setup_lsp)

-- < GOLANG >
lspc.gopls.setup({})

-- golang auto command
auto.cmd('FileType go', function()
    cmd([[set list listchars=tab:\ \ ]])
    cmd([[setlocal omnifunc=v:lua.vim.lsp.omnifunc]])
    vim.bo.expandtab = false
    vim.o.expandtab = false
    utils.indentn(4)
end)

-- go fmt after save
auto.cmd('BufWritePost *.go', function()
    utils.silent('!gofmt -w %')
    utils.silent('!goimports -w %')
    utils.silent('edit')
end)

auto.cmd('BufNewFile,BufRead *.mod', function()
    cmd([[set list listchars=tab:\ \ ]])
    vim.bo.expandtab = false
    vim.o.expandtab = false
    utils.indentn(4)
end)
