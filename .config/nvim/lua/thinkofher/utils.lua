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

return M
