local cmd = vim.cmd
local api = vim.api

-- local lua plugins
local auto = require('thinkofher.auto')
local utils = require('thinkofher.utils')

-- LANGUAGE SPECIFIC SETTINGS AND LSP
-- ==================================

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

-- < YAML >
auto.cmd('FileType yaml', function()
    utils.indentn(2)
end)

-- PLUGINS SETTINGS
-- ----------------

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
