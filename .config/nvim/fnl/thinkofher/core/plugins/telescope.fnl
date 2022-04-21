(import-macros {: *>} :thinkofher.macros)

(let [telescope (require :telescope)]
  (do
    (telescope.setup {:defaults {:layout_strategy :bottom_pane
                                 :layout_config {:bottom_pane {:height 15
                                                               :prompt_position :bottom}}
                                 :preview false}
                      :extensions {:fzf {:fuzzy true
                                         :override_generic_sorter true
                                         :override_file_sorter true
                                         :case_mode :smart_case}}}))
  (*> telescope.load-extension :fzf))

(let [builtin (require :telescope.builtin)]
  (do
    (vim.keymap.set :n :<C-p> builtin.find_files)
    (vim.keymap.set :n :<leader>fg builtin.live_grep)
    (vim.keymap.set :n :<leader>fb builtin.buffers)))
