;; lsp and langauge specific settings
(import-macros {:opt-local-set setl!} :zest.macros)

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
                    :gi vim.lsp.buf.implementation
                    :<c-k> vim.lsp.buf.signature_help
                    :<leader>wa vim.lsp.buf.add_workspace_folder
                    :<leader>wr vim.lsp.buf.remove_workspace_folder
                    :<leader>wl (fn [...]
                                  (print (vim.inspect
                                           (vim.lsp.buf.list_workspace_folders))))
                    :gr vim.lsp.buf.references
                    :g0 vim.lsp.buf.document_symbol
                    :gW vim.lsp.buf.workspace_symbol
                    :<leader>D vim.lsp.buf.type_definition
                    :<leader>rn vim.lsp.buf.rename
                    :<leader>ca vim.lsp.buf.code_action
                    :<leader>e vim.diagnostic.open_float
                    "[d" vim.diagnostic.goto_prev
                    "]d" vim.diagnostic.goto_next
                    :<leader>q vim.diagnostic.setloclist
                    :<leader>f vim.lsp.buf.formatting})

;; Table with command names and their callbacks.
(local lsp-commands {:LspDef  vim.lsp.buf.definition
                     :LspFormatting  vim.lsp.buf.formatting
                     :LspCodeAction  vim.lsp.buf.code_action
                     :LspHover  vim.lsp.buf.hover
                     :LspRename  vim.lsp.buf.rename
                     :LspRefs  vim.lsp.buf.references
                     :LspTypeDef  vim.lsp.buf.type_definition
                     :LspImplementation  vim.lsp.buf.implementation
                     :LspDiagPrev  vim.diagnostic.goto_prev
                     :LspDiagNext  vim.diagnostic.goto_next
                     :LspDiagLine  vim.diagnostic.open_float
                     :LspSignatureHelp  vim.lsp.buf.signature_help})

(fn lsp-on-attach [client bufnr]
  "Attaches key mappings and commands for language server protocol." 
  ;; Configure omnifunc for lsp.
  (setl! :omnifunc :v:lua.vim.lsp.omnifunc)
  ;; Configure vim diagnostics.
  (vim.diagnostic.config {:virtual_text false})
  ;; Setup all lsp keymaps for current buffer.
  (let [buf-set-keymap vim.api.nvim_buf_set_keymap
        set-keymap (fn [lhs callback]
                     (buf-set-keymap bufnr :n lhs "" {:silent true
                                                      :callback callback}))]
    (each [map callback (pairs lsp-keymaps)]
      (set-keymap map callback)))
  ;; Setup all lsp commands once, when attaching keymaps for buffer.
  (once (let [add-command vim.api.nvim_add_user_command]
          (each [cmd-name callback (pairs lsp-commands)]
            (add-command cmd-name callback {})))))

;; LSP servers that I'm currently using.
(local servers [:clangd
                :rust_analyzer
                :gopls])

;; Setup built-in LSP for each lsp server from above list.
(each [_ server (ipairs servers)]
  (let [config (. lsp-config server)]
    (config.setup {:on_attach lsp-on-attach})))
