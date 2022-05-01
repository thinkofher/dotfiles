(import-macros {: *>} :thinkofher.macros)

;; lsp and langauge specific settings
(local lsp-config (require :lspconfig))
(local builtin (require :telescope.builtin))

(local themes (require :thinkofher.core.plugins.telescope.themes))

;; LSP servers that I'm currently using.
(local servers [:clangd
                :rust_analyzer
                :gopls])


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
(local lsp-maps [[:LspDeclaration           :gd         vim.lsp.buf.declaration]
                 [:LspDefinition            "<c-]>"     vim.lsp.buf.definition]
                 [:LspHover                 :K          vim.lsp.buf.hover]
                 [:LspImplementation        :gi         implementations]
                 [:LspSignatureHelp         :<c-k>      vim.lsp.buf.signature_help]
                 [:LspsWorkspaceFolder      :<leader>wa vim.lsp.buf.add_workspace_folder]
                 [:LspRemoveWorkspaceFolder :<leader>wr vim.lsp.buf.remove_workspace_folder]
                 [:LspListWorkspaceFolders  :<leader>wl
                  #(print (vim.inspect
                            (vim.lsp.buf.list_workspace_folders)))]
                 [:LspRefs                  :gr         references]
                 [:LspDocumentSymbols       :g0
                  #(builtin.lsp_document_symbols (themes.get-ivy))]
                 [:LspWorkspaceSymbols      :gW         workspace-symbols]
                 [:LspTypeDefinition        :<leader>D  vim.lsp.buf.type_definition]
                 [:LspRename                :<leader>rn vim.lsp.buf.rename]
                 [:LspCodeAction            :<leader>ca code-action]
                 [:LspDiagLine              :<leader>e  vim.diagnostic.open_float]
                 [:LspDiagPrev              "[d"        vim.diagnostic.goto_prev]
                 [:LspDiagNext              "]d"        vim.diagnostic.goto_next]
                 [:LspDiagAll               :<leader>q  #(builtin.diagnostics (themes.get-ivy))]
                 [:LspFormatting            :<leader>f  vim.lsp.buf.formatting]])

(fn lsp-on-attach [client bufnr]
  "Attaches key mappings and commands for language server protocol." 
  ;; Configure vim diagnostics.
  (vim.diagnostic.config {:virtual_text false})
  ;; Setup all lsp keymaps for current buffer.
  (let [buf-set-keymap vim.api.nvim_buf_set_keymap
        buf-add-command vim.api.nvim_buf_create_user_command
        add-command (fn [cmd-name callback]
                      (buf-add-command bufnr cmd-name callback {}))
        set-keymap (fn [lhs callback]
                     (buf-set-keymap bufnr :n lhs "" {:silent true
                                                      :callback callback}))]
    (each [_ [name map callback] (ipairs lsp-maps)]
      (set-keymap map callback)
      (add-command name callback))))

;; Setup built-in LSP for each lsp server from above list.
(each [_ server (ipairs servers)]
  (let [config (. lsp-config server)]
    (config.setup {:on_attach lsp-on-attach})))
