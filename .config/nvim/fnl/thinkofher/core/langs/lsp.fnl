(import-macros {: *>} :thinkofher.macros)

;; lsp and langauge specific settings
(local lsp-config (require :lspconfig))
(local builtin (require :telescope.builtin))

(local themes (require :thinkofher.core.plugins.telescope.themes))

(macro once [body]
  "Evaluate given code only once during runtime."
  `(let [once-var# ,(tostring {}) ;; generates random table address at compile time
         run?# (. _G once-var#)]
     (when (not run?#)
       ,body
       (tset _G once-var# true))))

(fn references [...]
  "references shows telescope window with LSP references."
  (builtin.lsp_references (themes.get-ivy)))

(fn implementations [...]
  "implementations show telescope window with LSP implementations."
  (builtin.lsp_implementations (themes.get-ivy)))

(fn code-action [...]
  "code-action shows telescope window with LSP code actions."
  (builtin.lsp_code_actions (themes.get-ivy)))

(fn workspace-symbols [...]
  "workspace-symbols prompts user for a query string and runs
  telescope window for lsp workspace symbols with the given query."
  (let [res (pcall #(vim.ui.input {:prompt "Query: "
                                   :default ""}
                                  #(builtin.lsp_workspace_symbols
                                     (*> vim.tbl-deep-extend :force (themes.get-ivy) {:query $1}))))]
    (match res
      (false _) (print "Failed to run workspace/symbols callback." res))))

;; Table with key bindings and callbacks for them.
(local lsp-keymaps {:gd vim.lsp.buf.declaration
                    "<c-]>" vim.lsp.buf.definition
                    :K vim.lsp.buf.hover
                    :gi implementations
                    :<c-k> vim.lsp.buf.signature_help
                    :<leader>wa vim.lsp.buf.add_workspace_folder
                    :<leader>wr vim.lsp.buf.remove_workspace_folder
                    :<leader>wl #(print (vim.inspect
                                          (vim.lsp.buf.list_workspace_folders)))
                    :gr references
                    :g0 #(builtin.lsp_document_symbols (themes.get-ivy))
                    :gW workspace-symbols
                    :<leader>D vim.lsp.buf.type_definition
                    :<leader>rn vim.lsp.buf.rename
                    :<leader>ca code-action
                    :<leader>e vim.diagnostic.open_float
                    "[d" vim.diagnostic.goto_prev
                    "]d" vim.diagnostic.goto_next
                    :<leader>q #(builtin.diagnostics (themes.get-ivy))
                    :<leader>f vim.lsp.buf.formatting})

;; Table with command names and their callbacks.
(local lsp-commands {:LspDef  vim.lsp.buf.definition
                     :LspFormatting  vim.lsp.buf.formatting
                     :LspCodeAction  code-action
                     :LspHover  vim.lsp.buf.hover
                     :LspRename  #(vim.lsp.buf.rename)
                     :LspRefs  references
                     :LspTypeDef  vim.lsp.buf.type_definition
                     :LspImplementation implementations
                     :LspDiagPrev  vim.diagnostic.goto_prev
                     :LspDiagNext  vim.diagnostic.goto_next
                     :LspDiagLine  vim.diagnostic.open_float
                     :LspSignatureHelp  vim.lsp.buf.signature_help})

(fn lsp-on-attach [client bufnr]
  "Attaches key mappings and commands for language server protocol." 
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
  (once (let [add-command vim.api.nvim_create_user_command]
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
