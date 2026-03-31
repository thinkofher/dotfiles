vim.loader.enable(true)

local gh = function(x) return 'https://github.com/' .. x end

vim.pack.add {
    { src = gh('tpope/vim-fugitive'), version = '61b51c09b7c9ce04e821f6cf76ea4f6f903e3cf4' },
    { src = gh('tpope/vim-obsession'), version = 'ed9dfc7c2cc917ace8b24f4f9f80a91e05614b63' },
    { src = gh('tpope/vim-repeat'), version = '65846025c15494983dafe5e3b46c8f88ab2e9635' },

    { src = gh('mhinz/vim-signify'), version = '1a94c4124cd7d5b2f73352f7be38c14bd7441350' },

    { src = gh('folke/which-key.nvim'), version = '370ec46f710e058c9c1646273e6b225acf47cbed' },
    { src = gh('onsails/lspkind.nvim'), version = 'd79a1c3299ad0ef94e255d045bed9fa26025dab6' },
    { src = gh('ggandor/leap.nvim'), version = 'e9cb442c0614a7e8185608f639e10c54e53bb083' },

    { src = gh('thinkofher/pabianice'), version = 'c9c6834cc88cf80d60af86bb1faa11afa1b0de89' },
}

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require('leap').add_default_mappings()
require("pabianice").setup {
    icons = true,
    gui_font = "GohuFont uni14 Nerd Font:h14",
}

local au = vim.api.nvim_create_autocmd

au('LspAttach', {
    once = true,
    callback = function(ev)
        require("lspkind.").init()
    end,
})
