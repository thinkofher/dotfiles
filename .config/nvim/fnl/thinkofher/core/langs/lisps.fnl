;; lisps-family languages settings
(import-macros {: set!} :hibiscus.vim)
(import-macros {: **>} :thinkofher.macros)

(fn lisps-tabs [...]
  (set! tabstop 2)
  (set! softtabstop 2)
  (set! shiftwidth 2))

(**> create-augroup :Lisps {})

(**> create-autocmd :FileType {:group :Lisps
                               :desc "Setup size of tabs for lisp family languages."
                               :pattern [:lisp :racket :scheme :fennel]
                               :nested false
                               :once false
                               :callback lisps-tabs})
