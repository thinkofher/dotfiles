;; lsp and langauge specific settings

(local lsp-config (require :lspconfig))

(macro once [body]
  "Evaluate given code only once during runtime."
  `(let [once-var# ,(tostring {}) ;; generates random table address at compile time
         run?# (. _G once-var#)]
     (when (not run?#)
       ,body
       (tset _G once-var# true))))

;; Table with key bindings and callbacks for them.
(local lsp-keymaps {:gd vim.lsp.buf.declaration
                    "<c-]>" vim.lsp.buf.definition
                    :K vim.lsp.buf.hover
                    :gD vim.lsp.buf.implementation
                    :<c-k> vim.lsp.buf.signature_help
                    :1gD vim.lsp.buf.type_definition
                    :gr vim.lsp.buf.references
                    :g0 vim.lsp.buf.document_symbol
                    :gW vim.lsp.buf.workspace_symbol
                    :glf vim.lsp.buf.formatting})

;; Table with command names and their callbacks.
(local lsp-commands {:LspDef  vim.lsp.buf.definition
                     :LspFormatting  vim.lsp.buf.formatting
                     :LspCodeAction  vim.lsp.buf.code_action
                     :LspHover  vim.lsp.buf.hover
                     :LspRename  vim.lsp.buf.rename
                     :LspRefs  vim.lsp.buf.references
                     :LspTypeDef  vim.lsp.buf.type_definition
                     :LspImplementation  vim.lsp.buf.implementation
                     :LspDiagPrev  vim.lsp.diagnostic.goto_prev
                     :LspDiagNext  vim.lsp.diagnostic.goto_next
                     :LspDiagLine  vim.lsp.diagnostic.show_line_diagnostics
                     :LspSignatureHelp  vim.lsp.buf.signature_help})

(fn lsp-on-attach [client bufnr]
  "Attaches key mappings and commands for language server protocol." 
  (let [buf-set-keymap vim.api.nvim_buf_set_keymap
        set-keymap (fn [lhs callback]
                     (buf-set-keymap bufnr :n lhs "" {:silent true
                                                      :callback callback}))]
    (each [map callback (pairs lsp-keymaps)]
      (set-keymap map callback)))
  (once (let [add-command vim.api.nvim_add_user_command]
          (each [cmd-name callback (pairs lsp-commands)]
            (add-command cmd-name callback {})))))

;; LSP servers that I'm currently using.
(local servers [:clangd
                :rust_analyzer])

;; Setup built-in LSP for each lsp server from above list.
(each [_ server (ipairs servers)]
  (let [config (. lsp-config server)]
    (config.setup {:on_attach lsp-on-attach})))
