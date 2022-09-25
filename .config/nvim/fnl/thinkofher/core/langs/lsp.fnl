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
                  :keymap      :gd
                  :callback    vim.lsp.buf.declaration
                  :description "Declaration"}
                 {:command     :LspDefinition
                  :keymap      "<c-]>"
                  :callback    vim.lsp.buf.definition
                  :description "Definition"}
                 {:command     :LspHover
                  :keymap      :K
                  :callback    vim.lsp.buf.hover
                  :description "Hover"}
                 {:command     :LspImplementation
                  :keymap      :gi
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
                  :keymap      :gr
                  :callback    references
                  :description "References"}
                 {:command     :LspDocumentSymbols
                  :keymap      :g0
                  :callback     #(builtin.lsp_document_symbols (themes.get-ivy))
                  :description "Document symbols"}
                 {:command     :LspWorkspaceSymbols
                  :keymap      :gW
                  :callback    workspace-symbols
                  :description "Workspace symbols"}
                 {:command     :LspTypeDefinition
                  :keymap      :<leader>D
                  :callback    vim.lsp.buf.type_definition
                  :description "Type definition"}
                 {:command     :LspRename
                  :keymap      :<leader>rn
                  :callback    #(vim.lsp.buf.rename)
                  :description "Rename symbol"}
                 {:command     :LspCodeAction
                  :keymap      :<leader>ca
                  :callback    vim.lsp.buf.code_action
                  :description "Code action"}
                 {:command     :LspDiagLine
                  :keymap      :<leader>e
                  :callback    vim.diagnostic.open_float
                  :description "Show diagnostic"}
                 {:command     :LspDiagPrev
                  :keymap      "[d"
                  :callback    vim.diagnostic.goto_prev
                  :description "Go to next diagnostic"}
                 {:command     :LspDiagNext
                  :keymap      "]d"
                  :callback    vim.diagnostic.goto_next
                  :description "Go to prev diagnostic"}
                 {:command     :LspDiagAll
                  :keymap      :<leader>q
                  :callback    #(builtin.diagnostics (themes.get-ivy))
                  :description "All diagnostics"}
                 {:command     :LspFormatting
                  :keymap      :<leader>wf
                  :callback    vim.lsp.buf.formatting
                  :description "Format file"}])

(var omnifunc-cache {})

(fn _G.omnifunc_sync [findstart base]
  "Implements 'omnifunc' compatible sync LSP completion."
  (let [pos (**> win-get-cursor 0)
        line (**> get-current-line)]
    (if (= findstart 1)
      (do
        ;; Cache state of cursor line and position due to the fact that it will
        ;; change at the second call to this function (with `findstart = 0`). See:
        ;; https://github.com/vim/vim/issues/8510.
        ;;
        ;; This is needed because request to LSP server is made on second call.
        ;; If not done, server's completion mechanics will operate on different
        ;; document and position.
        (set omnifunc-cache {:pos pos
                             :line line})

        ;; On first call return column of completion start
        (let [line-to-cursor (line:sub 1 (. pos 2))]
          (vim.fn.match line-to-cursor :\k*$)))
      (do

        ;; Restore cursor line and position to the state of first call
        (**> set-current-line omnifunc-cache.line)
        (**> win-set-cursor 0 omnifunc-cache.pos)

        ;; Make request
        (let [bufnr (**> get-current-buf)
              params (*> vim.lsp.util.make-position-params)
              result (*> vim.lsp.buf-request-sync
                         bufnr
                         :textDocument/completion
                         params
                         2000)]
          (if (not result)
            {}

            ;; Transform request answer to list of completion matches
            (let [items {}]
              (each [_ item (pairs result)]
                (when (not item.err)
                  (let [matches (*>
                                  vim.lsp.util.text-document-completion-list-to-complete-items
                                  item.result
                                  base)]
                    (*> vim.list-extend items matches))))

              ;; Restore back cursor line and position to the state of this call's start
              ;; (avoids outcomes of Vim's internal line postprocessing)
              (**> set-current-line line)
              (**> win-set-cursor 0 pos)

              items)))))))

(fn lsp-on-attach [client bufnr]
  "Attaches key mappings and commands for language server protocol." 
  ;; Configure vim diagnostics.
  (vim.diagnostic.config {:virtual_text false})
  ;; Setup all lsp keymaps for current buffer.
  (let [buf-set-keymap vim.api.nvim_buf_set_keymap
        buf-add-command vim.api.nvim_buf_create_user_command
        add-command (fn [cmd-name callback desc]
                      (buf-add-command bufnr cmd-name callback {:desc desc}))
        set-keymap (fn [lhs callback desc]
                     (buf-set-keymap bufnr :n lhs "" {:silent true
                                                      :callback callback
                                                      :desc desc}))]
    (each [_ opts (ipairs lsp-maps)]
      (**> buf-set-option bufnr :omnifunc "v:lua.omnifunc_sync")
      (set-keymap opts.keymap opts.callback opts.description)
      (add-command opts.command opts.callback opts.description))))

;; Setup built-in LSP for each lsp server from above list.
(each [_ server (ipairs servers)]
  (let [config (. lsp-config server)]
    (config.setup {:on_attach lsp-on-attach})))
