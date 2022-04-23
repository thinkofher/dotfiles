(import-macros {: *>} :thinkofher.macros)

(let [telescope (require :telescope)
      fzf-config {:fuzzy true
                  :override_generic_sorter true
                  :override_file_sorter true
                  :case_mode :ignore_case}
      layout-config {:bottom_pane {:height 15
                                   :prompt_position :bottom}}]
  (do
    (telescope.setup {:defaults {:layout_strategy :bottom_pane
                                 :layout_config layout-config
                                 :preview false}
                      :extensions {:fzf fzf-config}}))
  (*> telescope.load-extension :fzf))

(let [builtin (require :telescope.builtin)
      themes (require :telescope.themes)
      custom-themes (require :thinkofher.core.plugins.telescope.themes)
      ivy (custom-themes.get-ivy)
      dropdown (themes.get_dropdown)]
  (do
    (vim.keymap.set :n :<C-p> #(builtin.find_files dropdown))
    (vim.keymap.set :n :<leader>fg #(builtin.live_grep ivy))
    (vim.keymap.set :n :<leader>fb #(builtin.buffers ivy))))
