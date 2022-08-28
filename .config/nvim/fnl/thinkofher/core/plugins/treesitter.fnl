(local contains vim.tbl_contains)
(local filter vim.tbl_filter)

(let [enabled-list [:fennel :commonlisp]
      parsers (require :nvim-treesitter.parsers)
      configs (require :nvim-treesitter.configs)
      ;; TreeSitter for elixir is extremly slow, so I choosed
      ;; to use regular regex-based highlighting.
      disabled [:elixir :html]]
  (configs.setup {:ensure_installed :all
                  :ignore_install disabled
                  :sync_install false
                  :indent {:enable false}
                  :rainbow {:enable true
                            :extended_mode false
                            :disable (filter
                                       #(not (contains enabled-list $1))
                                       (parsers.available_parsers))}
                  :highlight {:enable true
                              :disable disabled
                              :additional_vim_regex_highlighting disabled}
                  :incremental_selection {:enable true
                                          :keymaps {:init_selection :gnn
                                                    :node_incremental :grn
                                                    :scope_incremental :grc
                                                    :node_decremental :grm}}}))
