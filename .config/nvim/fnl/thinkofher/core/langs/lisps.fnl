;; lisps-family languages settings
(import-macros {: set!} :hibiscus.vim)
(import-macros {: **> : when-no-editorconfig} :thinkofher.macros)

(when-no-editorconfig (let [lisps-tabs (fn [...]
                                         (set! tabstop 2)
                                         (set! softtabstop 2)
                                         (set! shiftwidth 2))
                            lisp-patterns [:*.fnl :*.scm :*.rkt]]
                        (**> create-augroup :Lisps {})
                        (**> create-autocmd :BufEnter
                             {:group :Lisps
                              :desc "Setup size of tabs for lisp family languages."
                              :pattern lisp-patterns
                              :nested false
                              :once false
                              :callback lisps-tabs})))
