;; overall settings
(import-macros
  {: rem!
   : set!
   : set+} :hibiscus.vim)

;; Basics ;;

;; legacy stuff
(set! nocompatible)
(vim.cmd "filetype plugin on")
(vim.cmd "filetype plugin indent on")

;; finding files
(set+ path "**")
(set! wildmenu)

;; General Settings ;;

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

;; setup grep program if ripgrep is available
(when (vim.fn.executable :rg)
  (set! grepprg "rg --vimgrep --smart-case --hidden")
  (set! grepformat :%f:%l:%c:%m))

;; helper functions

;; P prints arguments in a pretty and user friendly way.
;;
;; Example usage with fennel:
;;   :Fnl (P 1 2 3 4)
;;
;; Example usage with lua:
;;   :lua P(1, 2, 3, 4)
(tset _G :P vim.pretty_print)

;; GUI ;;

;; gui settings for neovide
(when vim.g.neovide
  (set! guifont "Inconsolata:h15"))
