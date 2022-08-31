;; overall settings
(import-macros
  {: rem!
   : set!} :hibiscus.vim)

;; encoding
(set! encoding "utf-8")

;; required for operations modifying multiple buffers like rename
(set! hidden)

;; spaces & tabs
(set! tabstop 4)
(set! softtabstop 4)
(set! shiftwidth 4)

;; tabs are spaces
(set! expandtab)

(set! autoindent)

;; copy indent from the previous line
(set! copyindent)

;; searching files
(set! incsearch)
(set! ignorecase)

;; always show one statusline
(set! laststatus  3)

;; autocompletion
(rem! completeopt "preview")
(set! omnifunc "syntaxcomplete#Complete")

;; backup functionalities
(set! undofile)

;; don't wrap lines
(set! nowrap)

;; enable mouse support
(set! mouse :a)

;; gui settings for neovide
(when vim.g.neovide
  (set! guifont "Source Code Pro:h12"))
