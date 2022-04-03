(import-macros {: set!} :hibiscus.vim)
(import-macros {: *>
                : **>} :thinkofher.macros)

(fn go-tabs [...]
  (set! noexpandtab)
  (set! tabstop 4)
  (set! softtabstop 4)
  (set! shiftwidth 4))

(**> create-augroup :Go {})

(**> create-autocmd :BufWritePre {:group :Go
                                  :desc "Autoformat golang files on save."
                                  :pattern :*go
                                  :nested false
                                  :once false
                                  :callback (fn [...]
                                              (*> vim.lsp.buf.formatting-sync))})

(**> create-autocmd :BufEnter {:group :Go
                               :desc "Setup size of tabs for golang files."
                               :pattern [:*.go :go.mod :go.sum]
                               :nested false
                               :once false
                               :callback go-tabs})

(**> create-autocmd [:BufNewFile :BufRead] {:group :Go
                                            :desc "Setup size of tabs for go mod files."
                                            :pattern :*mod
                                            :nested false
                                            :once false
                                            :callback go-tabs})
