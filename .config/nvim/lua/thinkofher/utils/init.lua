local cmd = vim.cmd

local M = {}

-- silent runs given vim command silently
function M.silent(command)
    cmd('silent' .. ' ' .. command)
end

-- indentn sets tabstop, softtabstop and shiftwidth
-- to given number
function M.indentn(number)
    vim.o.tabstop = number -- number of visual spaces per TAB
    vim.bo.tabstop = number

    vim.o.softtabstop = number -- number of spaces in tab when editing
    vim.bo.softtabstop = number

    vim.o.shiftwidth = number -- number of spaces to use for autoindent
    vim.bo.shiftwidth = number
end

function M.setup_lsp()
    local vimp = require('vimp')
    local lsp = vim.lsp

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
end

return M
