local fn = vim.fn
local cmd = vim.cmd

local M = {}

function M.bootstrap()
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        cmd 'packadd packer.nvim'
    end
end

-- Mounts lua general purpose lua libraries.
local function libs(use)
    -- Write your .vimrc in Lua!
    use 'svermeulen/vimpeccable'

    -- Built-in lsp
    use 'neovim/nvim-lspconfig'
end

-- Mounts plugins for programming languages better support.
local function programming_languages(use)
    -- Fully featured Golang IDE for vim
    use 'fatih/vim-go'

    -- Plugin that provides Rust file detection, syntax highlighting,
    -- formatting, etc.
    use 'rust-lang/rust.vim'

    -- Emmet Plugin
    use 'mattn/emmet-vim'

    -- Plugin for elm syntax
    use 'ElmCast/elm-vim'

    -- Plugin for haskell syntax
    use 'neovimhaskell/haskell-vim'

    -- Elixir programming language support
    use 'elixir-editors/vim-elixir'

    -- Janet programming language support
    use 'bakpakin/janet.vim'

    -- For racket development
    use 'wlangstroth/vim-racket'
    use 'junegunn/rainbow_parentheses.vim'
end

-- Mounts all plugins with packer plugin manager.
function M.mount(use)
    -- Manager packer with packer
    use 'wbthomason/packer.nvim'

    libs(use)

    -- A Git wrapper so awesome, it should be illegal
    use 'tpope/vim-fugitive'

    -- The Plugin provides mappings to easily delete, change and add such surroundings in pairs
    use 'tpope/vim-surround'

    -- Vim comments Plugin
    use 'tpope/vim-commentary'

    -- Shows which lines have been added, modified, or removed
    use 'mhinz/vim-signify'

    -- Colorschemes
    use 'folke/tokyonight.nvim'

    -- fzf stands for “fuzzy finder” and works similarly to the Goto
    -- use { '~/.fzf', run = function() vim.fn['fzf#install']() end }
    use { 'junegunn/fzf', run = function() vim.fn['fzf#install']() end }
    use 'junegunn/fzf.vim'

    -- Editing gpg files
    use 'jamessan/vim-gnupg'

    -- Insert or delete brackets, parens, quotes in pair
    use 'jiangmiao/auto-pairs'

    programming_languages(use)
end

return M
