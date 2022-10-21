(import-macros {: use^ : kmp^ : lazy-hotpot} :thinkofher.macros)

(import-macros {: set! : g!} :hibiscus.vim)

(local packer (require :packer))

;; fnlfmt: skip
(fn fennel-env [use]
  "Mounts tools for configuring neovim with fennel language."
  ;; Hotpot lets you use fennel in Neovim anywhere you would use lua.
  (use :rktjmp/hotpot.nvim)

  ;; Highly opinionated macros to elegantly write your neovim config.
  (use :udayvir-singh/hibiscus.nvim)

  ;; Syntax highlighting for Fennel.
  (use^ :bakpakin/fennel.vim {:ft :fennel}))

;; fnlfmt: skip
(fn programming-langs [use]
  "Mounts plugins for programming languages better support."

  ;; Built-in lsp
  (use^ :neovim/nvim-lspconfig
        {:ft [:c :cpp :rust :go]
         :requires :ojroques/nvim-lspfuzzy
         :setup #(lazy-hotpot)
         :config #(let [lspfuzzy (require :lspfuzzy)]
                    (lspfuzzy.setup {})
                    (require :thinkofher.core.langs.lsp))})

  ;; Support for .editorconfig file.
  (use :editorconfig/editorconfig-vim)

  ;; Emmet Plugin
  (use^ :mattn/emmet-vim {:ft :html}))

(fn packer-bootstraped? []
  (. _G :packer_bootstrap))

;; fnlfmt: skip
(packer.startup (fn [use]
                  "Installs and mounts all plugins with packer plugin manager."

                  ;; Manage packer with packer
                  (use :wbthomason/packer.nvim)

                  ;; Mount fennel environment
                  (fennel-env use)

                  ;; Library of independent Lua modules.
                  (use^ :echasnovski/mini.nvim
                        {:branch :stable
                         :setup #(lazy-hotpot)
                         :config #(require :thinkofher.core.plugins.mini)})

                  ;; Leap is a general-purpose motion plugin for Neovim.
                  (use^ :ggandor/leap.nvim
                        {:config #(let [leap (require :leap)]
                                   (leap.add_default_mappings))
                         :requires :tpope/vim-repeat})

                  ;; A Git wrapper so awesome, it should be illegal
                  (use^ :tpope/vim-fugitive {:cmd :G})

                  ;; The Plugin provides mappings to easily delete, change
                  ;; and add such surroundings in pairs
                  (use :tpope/vim-surround)

                  ;; Shows which lines have been added, modified, or removed
                  (use^ :mhinz/vim-signify {:config #(set! updatetime 100)})

                  (use^ :junegunn/fzf.vim {:requires :junegunn/fzf
                                           :setup #(do
                                                     (g! fzf_command_prefix :Fzf)
                                                     (lazy-hotpot))
                                           :config #(require :thinkofher.core.plugins.fzf)})

                  ;; Collection of base16-based colorschemes for Vim.
                  (use^ :chriskempson/base16-vim
                        {:setup #(lazy-hotpot)
                         :config #(require :thinkofher.core.theme)})

                  ;; It displays a popup with possible key bindings of the command
                  ;; you started typing.
                  (use^ :folke/which-key.nvim
                        {:config #(let [wk (require :which-key)]
                                    (do
                                      (wk.register {:f {:name :find}
                                                    :p {:name :packer}
                                                    :b {:name :buffer}
                                                    :w {:name :workspace}
                                                    :c {:name :code}
                                                    :l {:name :lsp}}
                                                   {:prefix :<leader>})
                                      (wk.setup {})))})

                  ;; Mount programming langauges.
                  (programming-langs use)

                  ;; Bootstrap packer if necessary.
                  (when (packer-bootstraped?)
                    (packer.sync))))
