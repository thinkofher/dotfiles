;; lisps-family languages settings
(import-macros {: set!} :hibiscus.vim)
(import-macros {: **>} :thinkofher.macros)

(fn lisps-tabs [...]
  (set! tabstop 2)
  (set! softtabstop 2)
  (set! shiftwidth 2))

(local lisp-patterns [:*.fnl :*.scm :*.rkt])

(**> create-augroup :Lisps {})

(**> create-autocmd :BufEnter {:group :Lisps
                               :desc "Setup size of tabs for lisp family languages."
                               :pattern lisp-patterns
                               :nested false
                               :once false
                               :callback lisps-tabs})
