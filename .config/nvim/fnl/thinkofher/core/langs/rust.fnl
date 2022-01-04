;; Rust settings
(import-macros
  {:opt-local-set setl!
   : def-autocmd-fn} :zest.macros)

(def-autocmd-fn :FileType :rust
  (setl! :omnifunc "v:lua.vim.lsp.omnifunc"))
