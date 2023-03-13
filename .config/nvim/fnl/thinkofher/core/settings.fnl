;; overall settings
(import-macros {: rem! : set! : set+ : g!} :hibiscus.vim)

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
(set! encoding :utf-8)

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
(set! laststatus 3)

;; autocompletion
(rem! completeopt :preview)
(set! omnifunc "syntaxcomplete#Complete")

;; backup functionalities
(set! undofile)

;; don't wrap lines
(set! nowrap)

;; enable mouse support
(set! mouse :a)

(fn last [list n]
  "last returns last n elements of list. If n is not specified it
  returns only the single last element."
  (let [len (length list)
        shift (if n (- len (- n 1)) len)]
    (vim.list_slice list shift len)))

(fn join [strings sep]
  "join joins together strings elements from given list
  with seperator between them."
  (let [len (length strings)
        last-elem (if (> len 0) (. strings len) "")
        without-last (vim.list_slice strings 1 (- len 1))]
    (var res "")
    (each [_ s (ipairs without-last)]
      (set res (.. res s sep)))
    (.. res last-elem)))

(fn _G.short_path []
  "short_path returns short version of current file's name. Filenames other
  than the current one, are replaced with theirs first letter."
  (let [filename (vim.fn.expand "%")
        splitted (vim.split filename "/")
        len (length splitted)
        last (. splitted len)]
    (if (= len 1)
        filename
        ;; current opened filed is not in the directory
        (do
          ;; remove last element from table
          (table.remove splitted len)
          (let [only-first-letters (vim.tbl_map #($1:sub 1 1) splitted)
                longer-than-four (> (length only-first-letters) 4)
                truncate #(vim.list_slice $1 1 4)
                truncated (if longer-than-four (truncate only-first-letters)
                              only-first-letters)]
            (.. (if longer-than-four "..." "") (join truncated "/") "/" last))))))

;; setup terminal title
(set! title)
(set! titlestring "%{v:progname} [%{v:lua.short_path()} %l,%c %p%{'%'}]")

;; setup grep program if ripgrep is available
;;
;; search for the exact word foo (not foobar):
;;
;:  :grep -w foo (equivalent to :grep '\bfoo\b').
;;
;; search for foo in JavaScript files: 
;;
;;  :grep foo -t js
;;
;; search for foo in files matching a glob:
;;
;;  :grep foo -g '*.js'
;;
;; refs: https://phelipetls.github.io/posts/extending-vim-with-ripgrep/
(when (vim.fn.executable :rg)
  (set! grepprg "rg --vimgrep --smart-case --hidden")
  (set! grepformat "%f:%l:%c:%m"))

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
  (set! guifont "Inconsolata:h15")
  (g! neovide_cursor_vfx_mode "ripple"))
