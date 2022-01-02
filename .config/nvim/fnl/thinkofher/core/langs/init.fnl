;; lsp and langauge specific settings
(import-macros {: vlua-format
                : def-command-fn
                : def-keymap-fn} :zest.macros)

(fn lsp-setup []
  "Setup commands and keybindings for LSP."
  (def-command-fn :LspDef [] (vim.lsp.buf.definition))
  (def-command-fn :LspFormatting [] (vim.lsp.buf.formatting))
  (def-command-fn :LspCodeAction [] (vim.lsp.buf.code_action))
  (def-command-fn :LspHover [] (vim.lsp.buf.hover))
  (def-command-fn :LspRename [] (vim.lsp.buf.rename))
  (def-command-fn :LspRefs [] (vim.lsp.buf.references))
  (def-command-fn :LspTypeDef [] (vim.lsp.buf.type_definition))
  (def-command-fn :LspImplementation [] (vim.lsp.buf.implementation))
  (def-command-fn :LspDiagPrev [] (vim.lsp.diagnostic.goto_prev))
  (def-command-fn :LspDiagNext [] (vim.lsp.diagnostic.goto_next))
  (def-command-fn :LspDiagLine [] (vim.lsp.diagnostic.show_line_diagnostics))
  (def-command-fn :LspSignatureHelp [] (vim.lsp.buf.signature_help))

  (def-keymap-fn :gd [n :silent] (vim.lsp.buf.declaration))
  (def-keymap-fn "<c-]>" [n :silent] (vim.lsp.buf.definition))
  (def-keymap-fn :K [n :silent] (vim.lsp.buf.hover))
  (def-keymap-fn :gD [n :silent] (vim.lsp.buf.implementation))
  (def-keymap-fn :<c-k> [n :silent] (vim.lsp.buf.signature_help))
  (def-keymap-fn :1gD [n :silent] (vim.lsp.buf.type_definition))
  (def-keymap-fn :gr [n :silent] (vim.lsp.buf.references))
  (def-keymap-fn :g0 [n :silent] (vim.lsp.buf.document_symbol))
  (def-keymap-fn :gW [n :silent] (vim.lsp.buf.workspace_symbol))
  (def-keymap-fn :glf [n :silent] (vim.lsp.buf.formatting)))


(vim.api.nvim_command
  (vlua-format
    "autocmd FileType c,cpp,rust ++once :call %s()"
    (fn [...] (lsp-setup))))

(require :thinkofher.core.langs.c)
(require :thinkofher.core.langs.go)
(require :thinkofher.core.langs.rust)
(require :thinkofher.core.langs.web)
(require :thinkofher.core.langs.lisps)
(require :thinkofher.core.langs.data)
