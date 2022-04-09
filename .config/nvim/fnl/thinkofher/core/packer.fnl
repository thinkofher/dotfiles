(import-macros {: use-with-config} :thinkofher.macros)

(local packer (require :packer))

;; Mounts tools for configuring neovim with fennel language.
(fn fennel-env [use]
  ;; Hotpot lets you use fennel in Neovim anywhere you would use lua.
  (use :rktjmp/hotpot.nvim)

  ;; Highly opinionated macros to elegantly write your neovim config.
  (use :udayvir-singh/hibiscus.nvim)

  ;; Syntax highlighting for Fennel.
  (use :bakpakin/fennel.vim))

;; Mounts plugins for programming languages better support.
(fn programming-langs [use]
  ;; Built-in lsp
  (use :neovim/nvim-lspconfig)

  ;; Emmet Plugin
  (use :mattn/emmet-vim)

  ;; Plugin for elm syntax
  (use :ElmCast/elm-vim)

  ;; Plugin for elixir syntax
  (use :elixir-editors/vim-elixir)

  ;; Janet programming language support
  (use :bakpakin/janet.vim)

  ;; For racket development
  (use :wlangstroth/vim-racket))

(fn packer-bootstraped? []
  (. _G :packer_bootstrap))

;; Install and mount all plugins with packer plugin manager.
(packer.startup (fn [...]
                  ;; Manage packer with packer
                  (use :wbthomason/packer.nvim)

                  ;; Mount fennel environment
                  (fennel-env use)

                  (use-with-config :echasnovski/mini.nvim {:branch :stable})

                  ;; Lightspeed is a cutting-edge motion plugin for Neovim.
                  (use :ggandor/lightspeed.nvim)

                  ;; A Git wrapper so awesome, it should be illegal
                  (use :tpope/vim-fugitive)

                  ;; The Plugin provides mappings to easily delete, change
                  ;; and add such surroundings in pairs
                  (use :tpope/vim-surround)

                  ;; Enhanced version vcscommand.vim, with full support for fossil.
                  (use :hdrz/vcscommand.vim)

                  ;; Shows which lines have been added, modified, or removed
                  (use :mhinz/vim-signify)

                  ;; telescope.nvim is a highly extendable fuzzy finder over lists.
                  (use-with-config
                    :nvim-telescope/telescope.nvim
                    {:requires [:nvim-lua/plenary.nvim]})

                  ;; fzf-native is a c port of fzf
                  (use-with-config
                    :nvim-telescope/telescope-fzf-native.nvim
                    {:run :make})

                  ;; Collection of base16-based colorschemes for Vim.
                  (use :chriskempson/base16-vim)

                  ;; Editing gpg files
                  (use :jamessan/vim-gnupg)

                  ;; Mount programming langauges
                  (programming-langs use)

                  (when (packer-bootstraped?)
                    (let [packer (require :packer)]
                      (packer.sync)))))
