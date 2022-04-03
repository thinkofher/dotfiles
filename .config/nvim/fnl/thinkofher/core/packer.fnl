(import-macros {: *>
                : use-with-config} :thinkofher.macros)

(local packer (require :packer))

;; Mounts tools for configuring neovim with fennel language.
(fn fennel-env [use]
  ;; Hotpot lets you use fennel in Neovim anywhere you would use lua.
  (use "rktjmp/hotpot.nvim")

  ;; Highly opinionated macros to elegantly write your neovim config.
  (use "udayvir-singh/hibiscus.nvim")

  ;; Syntax highlighting for Fennel.
  (use "bakpakin/fennel.vim"))

;; Mounts plugins for programming languages better support.
(fn programming-langs [use]
  ;; Built-in lsp
  (use "neovim/nvim-lspconfig")

  ;; Treesitter support for neovim.
  (use-with-config "nvim-treesitter/nvim-treesitter" {:run ":TSUpdate"})

  ;; Rainbow parentheses for treesitter.
  (use "p00f/nvim-ts-rainbow")

  ;; Emmet Plugin
  (use "mattn/emmet-vim")

  ;; Plugin for elm syntax
  (use "ElmCast/elm-vim")

  ;; Plugin for elixir syntax
  (use "elixir-editors/vim-elixir")

  ;; Janet programming language support
  (use "bakpakin/janet.vim")

  ;; For racket development
  (use "wlangstroth/vim-racket"))

(fn packer-bootstraped? []
  (. _G :packer_bootstrap))

;; Install and mount all plugins with packer plugin manager.
(packer.startup (fn [...]
                  ;; Manage packer with packer
                  (use "wbthomason/packer.nvim")

                  ;; Mount fennel environment
                  (fennel-env use)

                  ;; A Git wrapper so awesome, it should be illegal
                  (use "tpope/vim-fugitive")

                  ;; Enhanced version vcscommand.vim, with full support for fossil.
                  (use "hdrz/vcscommand.vim")

                  ;; The Plugin provides mappings to easily delete, change and add such surroundings in pairs
                  (use "tpope/vim-surround")

                  ;; Vim comments Plugin
                  (use "tpope/vim-commentary")

                  ;; Shows which lines have been added, modified, or removed
                  (use "mhinz/vim-signify")

                  ;; Colorschemes
                  (use "folke/tokyonight.nvim")

                  ;; fzf stands for “fuzzy finder” and works similarly to the Goto
                  (use-with-config
                    "junegunn/fzf"
                    {:run (fn [] (let [fzf-install (. vim.fn "fzf#install")]
                                   (fzf-install)))})
                  (use "junegunn/fzf.vim")

                  ;; Editing gpg files
                  (use "jamessan/vim-gnupg")

                  ;; Insert or delete brackets, parens, quotes in pair
                  (use "jiangmiao/auto-pairs")

                  ;; Mount programming langauges
                  (programming-langs use)

                  (when (packer-bootstraped?)
                    (let [packer (require :packer)]
                      (packer.sync)))))
