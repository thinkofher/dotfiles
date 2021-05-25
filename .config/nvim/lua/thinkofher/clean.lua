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
auto.cmd('FileType go', function()
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

-- < GOLANG >
lspc.gopls.setup({})

-- golang auto command
auto.cmd('FileType go', function()
    cmd([[set list listchars=tab:\ \ ]])
    cmd([[setlocal omnifunc=v:lua.vim.lsp.omnifunc]])
    vim.bo.expandtab = false
    vim.o.expandtab = false
    utils.indentn(4)

    -- go fmt after save
    auto.cmd('BufWritePost *', function()
        utils.silent('!gofmt -w %')
        utils.silent('!goimports -w %')
        utils.silent('edit')
    end)
end)

auto.cmd('BufNewFile,BufRead *.mod', function()
    cmd([[set list listchars=tab:\ \ ]])
    vim.bo.expandtab = false
    vim.o.expandtab = false
    utils.indentn(4)
end)
