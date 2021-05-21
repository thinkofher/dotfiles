local charset = {}

for i = 48,  57 do table.insert(charset, string.char(i)) end
for i = 65,  90 do table.insert(charset, string.char(i)) end
for i = 97, 122 do table.insert(charset, string.char(i)) end

function string.random(length)
  math.randomseed(os.time())

  if length > 0 then
    return string.random(length - 1) .. charset[math.random(1, #charset)]
  else
    return ""
  end
end

F = {}

function auto(query, f)
	str = string.random(10)
	F[str] = f
	command = string.format("autocmd %s lua F[\"%s\"]()", query, str)
	vim.api.nvim_command(command)
end

auto("FileType go", function()
	vim.bo.expandtab = false
	vim.o.expandtab = false
	
	vim.bo.tabstop = 4
	vim.o.tabstop = 4

	vim.bo.softtabstop = 4
	vim.o.softtabstop = 4
end)

auto("BufWritePost *.go", function()
    vim.api.nvim_command("!gofmt -w %")
    vim.api.nvim_command("!goimports -w %")
    vim.api.nvim_command("edit")
end)
