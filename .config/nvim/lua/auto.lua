local M = {}

__auto_funcs = {}
__counter = 0

function M.cmd(query, f)
    __auto_funcs[__counter] = f

    local command = string.format("autocmd %s lua __auto_funcs[%d]()", query, __counter)
    vim.api.nvim_command(command)

    __counter = __counter + 1
end

return M
