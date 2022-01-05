(import-macros {:opt-set set!
                : def-autocmd-fn} :zest.macros)

(def-autocmd-fn :FileType :go
  (set! :expandtab false)
  (set! :tabstop 4)
  (set! :softtabstop 4)
  (set! :shiftwidth 4))

(def-autocmd-fn [:BufNewFile :BufRead] :*.mod
  (set! :expandtab false)
  (set! :tabstop 4)
  (set! :softtabstop 4)
  (set! :shiftwidth 4))

(def-autocmd-fn :BufWritePost :*go
  (vim.lsp.buf.formatting))
