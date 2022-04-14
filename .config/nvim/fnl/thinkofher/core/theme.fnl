(import-macros {: set!} :hibiscus.vim)

;; Enable syntax highlighting
(vim.cmd "syntax enable")

;; Enable support for true colors
(set! notermguicolors)

;; Load the colorscheme
(vim.cmd "colorscheme default")
(vim.cmd "highlight VertSplit cterm=None")
