(import-macros {: set!} :hibiscus.vim)

;; Enable syntax highlighting
(vim.cmd "syntax enable")

;; Enable support for true colors
(set! termguicolors)

;; Load the colorscheme
(vim.cmd "colorscheme base16-default-dark")
(vim.cmd "highlight VertSplit guibg=None")
