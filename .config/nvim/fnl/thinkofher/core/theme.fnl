(import-macros {: set!} :hibiscus.vim)
(import-macros {: **>} :thinkofher.macros)

;; Enable syntax highlighting
(vim.cmd "syntax enable")

;; Enable support for true colors
(set! termguicolors)

(local color-scheme :base16-default-dark)

(**> create-autocmd :ColorScheme {:pattern color-scheme
                                  :desc "Color scheme settings."
                                  :once false
                                  :nested false
                                  :callback #(vim.cmd.highlight [:VertSplit :guibg=None])})

;; Load the colorscheme
(vim.cmd.colorscheme color-scheme)
