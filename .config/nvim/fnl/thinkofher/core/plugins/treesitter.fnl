(local contains vim.tbl_contains)
(local filter vim.tbl_filter)

(let [enabled-list [:fennel :commonlisp]
      parsers (require :nvim-treesitter.parsers)
      configs (require :nvim-treesitter.configs)]
  (configs.setup {:ensure_installed "maintained"
                  :sync_install false
                  :indent {:enable false}
                  :rainbow {:enable true
                            :extended_mode false
                            :disable (filter
                                       #(not (contains enabled-list $1))
                                       (parsers.available_parsers))}
                  :highlight {:enable true
                              :additional_vim_regex_highlighting false}}))
