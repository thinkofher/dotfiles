(import-macros {: **>} :thinkofher.macros)

;; setup map leader
(tset vim.g :mapleader " ")

;; mappings for moving lines
(let [move-lines-maps [[:n :∆ ":m .+1<cr>=="]
                       [:n :Ż ":m .-2<cr>=="]
                       [:v :∆ ":m '>+1<cr>gv=gv"]
                       [:v :Ż ":m '<-2<cr>gv=gv"]]]
  (each [_ [mode lhs rhs] (pairs move-lines-maps)]
    (vim.keymap.set mode lhs rhs)))

;; terminal settings
(vim.keymap.set :t :<c-v><esc> "<c-\\><c-n>")
(vim.keymap.set :n :<leader>t ":tabnew<cr>:terminal<cr>")

(**> create-augroup :Terminal {})

(**> create-autocmd :TermOpen {:group :Terminal
                               :desc "Setup no spelling for terminal buffers."
                               :pattern :*
                               :nested false
                               :once false
                               :callback #(tset vim.wo :spell false)})

(**> create-autocmd [:TermOpen :BufEnter] {:group :Terminal
                                           :desc "Start text insert when entering term."
                                           :pattern "term://*"
                                           :nested false
                                           :once false
                                           :callback #(vim.cmd :startinsert)})
