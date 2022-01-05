(let [configs (require :nvim-treesitter.configs)]
  (configs.setup {:ensure_installed "maintained"
                  :sync_install false
                  :highlight {:enable true
                              :additional_vim_regex_highlighting false}}))
