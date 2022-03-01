(import-macros {:opt-set set!} :zest.macros)
(import-macros {: *>
                : **>} :thinkofher.macros)

(fn go-tabs [...]
  (set! :expandtab false)
  (set! :tabstop 4)
  (set! :softtabstop 4)
  (set! :shiftwidth 4))

(**> create-augroup :Go {})

(**> create-autocmd :BufWritePre {:group :Go
                                  :desc "Autoformat golang files on save."
                                  :pattern :*go
                                  :nested false
                                  :once false
                                  :callback (fn [...]
                                              (*> vim.lsp.buf.formatting-sync))})

(**> create-autocmd :FileType {:group :Go
                               :desc "Setup size of tabs for golang files."
                               :pattern :go
                               :nested false
                               :once false
                               :callback go-tabs})

(**> create-autocmd [:BufNewFile :BufRead] {:group :Go
                                            :desc "Setup size of tabs for go mod files."
                                            :pattern :*mod
                                            :nested false
                                            :once false
                                            :callback go-tabs})
