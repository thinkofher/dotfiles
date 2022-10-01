(import-macros {: *>
                : **>} :thinkofher.macros)

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
(local lsp-maps [{:command     :LspDeclaration
                  :keymap      [:gd :<leader>ld]
                  :callback    vim.lsp.buf.declaration
                  :description "Declaration"}
                 {:command     :LspDefinition
                  :keymap      ["<c-]>" "<leader>l]"]
                  :callback    vim.lsp.buf.definition
                  :description "Definition"}
                 {:command     :LspHover
                  :keymap      [:K :<leader>lh]
                  :callback    vim.lsp.buf.hover
                  :description "Hover"}
                 {:command     :LspImplementation
                  :keymap      [:gi :<leader>lI]
                  :callback    implementations
                  :description "Implementations"}
                 {:command     :LspSignatureHelp
                  :keymap      :<c-k>
                  :callback    vim.lsp.buf.signature_help
                  :description "Signature help"}
                 {:command     :LspsWorkspaceFolder
                  :keymap      :<leader>wa
                  :callback    vim.lsp.buf.add_workspace_folder
                  :description "Addw workspace folder"}
                 {:command     :LspRemoveWorkspaceFolder
                  :keymap      :<leader>wr
                  :callback    vim.lsp.buf.remove_workspace_folder
                  :description "Remove workspace folder"}
                 {:command     :LspListWorkspaceFolders
                  :keymap      :<leader>wl
                  :callback    #(print (vim.inspect
                                         (vim.lsp.buf.list_workspace_folders)))
                  :description "List workspace folders"}
                 {:command     :LspRefs
                  :keymap      [:gr :<leader>lr]
                  :callback    references
                  :description "References"}
                 {:command     :LspDocumentSymbols
                  :keymap      [:g0 :<leader>ls]
                  :callback     #(builtin.lsp_document_symbols (themes.get-ivy))
                  :description "Document symbols"}
                 {:command     :LspWorkspaceSymbols
                  :keymap      [:gW :<leader>lw]
                  :callback    workspace-symbols
                  :description "Workspace symbols"}
                 {:command     :LspTypeDefinition
                  :keymap      [:<leader>D :<leader>lD]
                  :callback    vim.lsp.buf.type_definition
                  :description "Type definition"}
                 {:command     :LspRename
                  :keymap      [:<leader>rn :<leader>ln]
                  :callback    #(vim.lsp.buf.rename)
                  :description "Rename symbol"}
                 {:command     :LspCodeAction
                  :keymap      [:<leader>ca :<leader>la]
                  :callback    vim.lsp.buf.code_action
                  :description "Code action"}
                 {:command     :LspDiagLine
                  :keymap      [:<leader>e :<leader>le]
                  :callback    vim.diagnostic.open_float
                  :description "Show diagnostic"}
                 {:command     :LspDiagPrev
                  :keymap      ["[d" :<leader>li]
                  :callback    vim.diagnostic.goto_prev
                  :description "Go to next diagnostic"}
                 {:command     :LspDiagNext
                  :keymap      ["]d" :<leader>lo]
                  :callback    vim.diagnostic.goto_next
                  :description "Go to prev diagnostic"}
                 {:command     :LspDiagAll
                  :keymap      [:<leader>q :<leader>lA]
                  :callback    #(builtin.diagnostics (themes.get-ivy))
                  :description "All diagnostics"}
                 {:command     :LspFormatting
                  :keymap      [:<leader>wf :<leader>lf]
                  :callback    #(vim.lsp.buf.format)
                  :description "Format file"}])

(fn lsp-on-attach [client bufnr]
  "Attaches key mappings and commands for language server protocol." 
  ;; Configure vim diagnostics.
  (vim.diagnostic.config {:virtual_text false})
  ;; Setup all lsp keymaps for current buffer.
  (let [buf-set-keymap vim.api.nvim_buf_set_keymap
        buf-add-command vim.api.nvim_buf_create_user_command
        add-command (fn [cmd-name callback desc]
                      (buf-add-command bufnr cmd-name callback {:desc desc}))
        set-keymap-single (fn [lhs callback desc]
                            (buf-set-keymap bufnr :n lhs "" {:silent true
                                                             :callback callback
                                                             :desc desc}))
        set-keymap-for-all (fn [lhs callback desc]
                             (vim.tbl_map #(set-keymap-single $1 callback desc) lhs))
        set-keymap (fn [lhs callback desc]
                     (match lhs
                       (where s (= (type s) :string)) (set-keymap-single s callback desc)
                       (where l (= (type l) :table)) (set-keymap-for-all l callback desc)
                       _ (error (string.format
                                  "%s is not table nor string, but %s"
                                  (vim.inspect lhs)
                                  (type lhs)))))]
    (each [_ opts (ipairs lsp-maps)]
      (**> buf-set-option bufnr :omnifunc "v:lua.vim.lsp.omnifunc")
      (set-keymap opts.keymap opts.callback opts.description)
      (add-command opts.command opts.callback opts.description))))

;; Setup built-in LSP for each lsp server from above list.
(each [_ server (ipairs servers)]
  (let [config (. lsp-config server)]
    (config.setup {:on_attach lsp-on-attach})))
