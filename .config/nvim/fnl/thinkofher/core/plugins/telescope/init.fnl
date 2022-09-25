(import-macros {: *>} :thinkofher.macros)

(local custom-themes (require :thinkofher.core.plugins.telescope.themes))

(let [telescope (require :telescope)
      fzf-config {:fuzzy true
                  :override_generic_sorter true
                  :override_file_sorter true
                  :case_mode :ignore_case}
      layout-config {:bottom_pane {:height 15
                                   :prompt_position :bottom}}
      ui-select-config [(custom-themes.get-ivy)]
      extensions [:fzf :ui-select]]
  (do
    (telescope.setup {:defaults {:layout_strategy :bottom_pane
                                 :layout_config layout-config
                                 :preview false}
                      :extensions {:fzf fzf-config
                                   :ui-select ui-select-config}})
    (each [_ extension (ipairs extensions)]
      (*> telescope.load-extension extension))))

(let [builtin (require :telescope.builtin)]
  (do
    (let [find-files-mappings [:<C-p> :<leader>ff]]
      (each [_ mapping (ipairs find-files-mappings)]
        (vim.keymap.set :n
                        mapping
                        #(builtin.find_files (custom-themes.get-ivy))
                        {:desc "Find file"})))
    (vim.keymap.set :n
                    :<leader>fg
                    #(builtin.live_grep (custom-themes.get-ivy))
                    {:desc "Live grep"})
    (vim.keymap.set :n
                    :<leader>fb
                    #(builtin.buffers (custom-themes.get-ivy))
                    {:desc "Find buffer"})))
