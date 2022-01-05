(import-macros {: def-keymap} :zest.macros)

;; setup map leader
(tset vim.g :mapleader " ")

;; mappings for moving lines
(def-keymap [n]
  {"∆" ":m .+1<cr>=="
   "Ż" ":m .-2<cr>=="})
(def-keymap [v]
  { "∆" ":m '>+1<cr>gv=gv"
    "Ż" ":m '<-2<cr>gv=gv"})

;; terminal settings
(def-keymap "<leader>t" [n] ":tabnew<cr>:terminal<cr>")
(def-keymap "<esc>" [t] "<c-\\><c-n>")
