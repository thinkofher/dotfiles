(import-macros {: set!} :hibiscus.vim)
(import-macros {: *>
                : **>} :thinkofher.macros)

(fn go-tabs [...]
  (set! noexpandtab)
  (set! tabstop 4)
  (set! softtabstop 4)
  (set! shiftwidth 4)
  (set! makeprg "go build ./..."))

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

(fn go-lint [opts]
  "Lint Golang code with golanci-lint. It is required
  for the user to have golangci-lint installed on its
  machine."
  (let [old (. vim.o :makeprg)
        new "golangci-lint run --print-issued-lines=0"]
    (do
      (set! makeprg new)
      (vim.cmd "make")
      (set! makeprg old))))

(**> create-user-command :GoLint go-lint {:bang false})
