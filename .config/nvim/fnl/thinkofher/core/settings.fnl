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

;; always show statusline
(set! laststatus  2)

;; autocompletion
(rem! completeopt "preview")
(set! omnifunc "syntaxcomplete#Complete")

;; backup functionalities
(set! undofile)

;; don't wrap lines
(set! wrap)

(set! listchars {:trail "." :extends ">"})

;; enable mouse support
(set! mouse :a)
