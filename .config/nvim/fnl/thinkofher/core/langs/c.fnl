;; C, Cpp settings
(import-macros
  {:opt-set set!
   :opt-local-set setl!
   : def-autocmd-fn} :zest.macros)

;; C, Cpp auto command
(def-autocmd-fn :FileType [:c :cpp]
  (set! :tabstop 2)
  (set! :softtabstop 2)
  (set! :shiftwidth 2))

;; run clang-format after every buffer write
(def-autocmd-fn :BufWritePost [:*c :*cpp :*h :*hpp]
  (vim.lsp.buf.formatting))
