;; C, Cpp settings
(import-macros
  {:opt-set set!
   :opt-local-set setl!
   : def-autocmd-fn} :zest.macros)

(let [lsp-config (require :lspconfig)]
  (lsp-config.clangd.setup []))

;; C, Cpp auto command
(def-autocmd-fn :FileType [:c :cpp]
  (setl! :omnifunc "v:lua.vim.lsp.omnifunc")
  (set! :tabstop 2)
  (set! :softtabstop 2)
  (set! :shiftwidth 2))

;; run clang-format after every buffer write
(def-autocmd-fn :BufWritePost [:*c :*cpp :*h :*hpp]
  (vim.cmd "silent !clang-format -i %")
  (vim.cmd "silent edit"))
