;; Rust settings
(import-macros
  {:opt-local-set setl!
   : def-autocmd-fn} :zest.macros)

(let [lsp-config (require :lspconfig)]
  (lsp-config.rust_analyzer.setup []))

(def-autocmd-fn :FileType :rust
  (setl! :omnifunc "v:lua.vim.lsp.omnifunc"))
