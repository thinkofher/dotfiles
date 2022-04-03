(import-macros {: set+
                : set!} :hibiscus.vim)

;; legacy stuff
(set! nocompatible)
(vim.cmd "filetype plugin on")
(vim.cmd "filetype plugin indent on")

;; finding files
(set+ path "**")
(set! wildmenu)
