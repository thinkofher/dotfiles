local pack = "packer"

local function bootstrap (url)
    local name = url:gsub(".*/", "")
    local path = vim.fn.stdpath [[data]] .. "/site/pack/".. pack .. "/start/" .. name

    local result = nil
    if vim.fn.isdirectory(path) == 0 then
        print(name .. ": installing in data dir...")

        result = vim.fn.system {"git", "clone", "--depth", "1", url, path}

        vim.cmd [[redraw]]
        print(name .. ": finished installing")

    end

    return result
end

bootstrap "https://github.com/rktjmp/hotpot.nvim"
bootstrap "https://github.com/udayvir-singh/hibiscus.nvim"

_G.packer_bootstrap = bootstrap "https://github.com/wbthomason/packer.nvim"
if _G.packer_bootstrap then
    vim.cmd [[packadd packer.nvim]]
end

if _G.lazy_hotpot == nil then
    require("hotpot").setup({
        provide_require_fennel = true,
        compiler = {
            macros = {
                env = "_COMPILER",
                compilerEnv = _G,
                allowedGlobals = false,
            },
        },
    })
end

require('thinkofher.core')
