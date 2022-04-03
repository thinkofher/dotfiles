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
(vim.keymap.set :t :<esc> "<c-\\><c-n>")
(vim.keymap.set :n :<leader>t ":tabnew<cr>:terminal<cr>")
