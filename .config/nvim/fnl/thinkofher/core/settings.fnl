;; overall settings

(import-macros
  {:opt-remove set-
   :opt-set set!} :zest.macros)

;; encoding
(set! :encoding "utf-8")

;; required for operations modifying multiple buffers like rename
(set! :hidden true)

;; spaces & tabs
(set! :tabstop 4)
(set! :softtabstop 4)
(set! :shiftwidth 4)

;; tabs are spaces
(set! :expandtab true)

(set! :autoindent true)

;; copy indent from the previous line
(set! :copyindent true)

;; searching files
(set! :incsearch  true)
(set! :ignorecase true)

;; always show statusline
(set! :laststatus  2)

;; autocompletion
(set- :completeopt "preview")
(set! :omnifunc "syntaxcomplete#Complete")

;; backup functionalities
(set! :undofile true)

;; don't wrap lines
(set! :wrap false)

(set! :listchars {:trail "." :extends ">"})

;; enable mouse support
(set! :mouse :a)
