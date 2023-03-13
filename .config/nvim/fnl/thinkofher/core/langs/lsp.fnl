(import-macros {: *> : **>} :thinkofher.macros)

;; lsp and langauge specific settings
(local lsp-config (require :lspconfig))

;; LSP servers that I'm currently using.
(local servers [:clangd :rust_analyzer :gopls])

;; Table with key bindings and callbacks for them.

;; fnlfmt: skip
(local lsp-maps [{:sub         :declaration
                  :keymap      [:gd :<leader>ld]
                  :callback    vim.lsp.buf.declaration
                  :description "Declaration"}
                 {:sub         :definition
                  :keymap      ["<c-]>" "<leader>l]"]
                  :callback    vim.lsp.buf.definition
                  :description "Definition"}
                 {:sub         :hover
                  :keymap      [:K :<leader>lh]
                  :callback    vim.lsp.buf.hover
                  :description "Hover"}
                 {:sub         :implementation
                  :keymap      [:gi :<leader>lI]
                  :callback    vim.lsp.buf.implementation
                  :description "Implementations"}
                 {:sub         :signature_help
                  :keymap      :<c-k>
                  :callback    vim.lsp.buf.signature_help
                  :description "Signature help"}
                 {:sub         :workspace_folder
                  :keymap      :<leader>wa
                  :callback    vim.lsp.buf.add_workspace_folder
                  :description "Addw workspace folder"}
                 {:sub         :remove_workspace_folder
                  :keymap      :<leader>wr
                  :callback    vim.lsp.buf.remove_workspace_folder
                  :description "Remove workspace folder"}
                 {:sub         :list_workspace_folders
                  :keymap      :<leader>wl
                  :callback    #(print (vim.inspect
                                         (vim.lsp.buf.list_workspace_folders)))
                  :description "List workspace folders"}
                 {:sub         :refs
                  :keymap      [:gr :<leader>lr]
                  :callback    vim.lsp.buf.references
                  :description "References"}
                 {:sub         :document_symbols
                  :keymap      [:g0 :<leader>ls]
                  :callback     #(vim.lsp.buf.document_symbol)
                  :description "Document symbols"}
                 {:sub         :workspace_symbols
                  :keymap      [:gW :<leader>lw]
                  :callback    vim.lsp.buf.workspace_symbol
                  :description "Workspace symbols"}
                 {:sub         :type_definition
                  :keymap      [:<leader>D :<leader>lD]
                  :callback    vim.lsp.buf.type_definition
                  :description "Type definition"}
                 {:sub         :rename
                  :keymap      [:<leader>rn :<leader>ln]
                  :callback    #(vim.lsp.buf.rename)
                  :description "Rename symbol"}
                 {:sub         :code_action
                  :keymap      [:<leader>ca :<leader>la]
                  :callback    vim.lsp.buf.code_action
                  :description "Code action"}
                 {:sub         :diag_line
                  :keymap      [:<leader>e :<leader>le]
                  :callback    vim.diagnostic.open_float
                  :description "Show diagnostic"}
                 {:sub         :diag_prev
                  :keymap      ["[d" :<leader>li]
                  :callback    vim.diagnostic.goto_prev
                  :description "Go to next diagnostic"}
                 {:sub         :diag_next
                  :keymap      ["]d" :<leader>lo]
                  :callback    vim.diagnostic.goto_next
                  :description "Go to prev diagnostic"}
                 {:sub         :diag_all
                  :keymap      [:<leader>q :<leader>lA]
                  :callback    #(vim.diagnostic.setqflist)
                  :description "All diagnostics"}
                 {:sub         :formatting
                  :keymap      [:<leader>wf :<leader>lf]
                  :callback    #(vim.lsp.buf.format)
                  :description "Format file"}])

(fn setup-icons []
  (let [kinds vim.lsp.protocol.CompletionItemKind
        icons {:Text ""
               :Method ""
               :Function ""
               :Constructor ""
               :Field "ﰠ"
               :Variable ""
               :Class "ﴯ"
               :Interface ""
               :Module ""
               :Property "ﰠ"
               :Unit "塞"
               :Value ""
               :Enum ""
               :Keyword ""
               :Snippet ""
               :Color ""
               :File ""
               :Reference ""
               :Folder ""
               :EnumMember ""
               :Constant ""
               :Struct "פּ"
               :Event ""
               :Operator ""
               :TypeParameter ""}]
    (each [i kind (ipairs kinds)]
           (tset kinds i (or (. icons kind) kind)))))

(fn lsp-on-attach [client bufnr]
  "Attaches key mappings and commands for language server protocol."
  ;; Configure vim diagnostics.
  (vim.diagnostic.config {:virtual_text false})
  ;; Setup all lsp keymaps for current buffer.
  (let [options {:omnifunc "v:lua.vim.lsp.omnifunc"
                 :formatexpr "v:lua.vim.lsp.formatexpr(#{timeout_ms:250})"}
        buf-set-keymap vim.api.nvim_buf_set_keymap
        buf-add-command vim.api.nvim_buf_create_user_command
        cmd-callback (fn [opts]
                       (let [filtered (vim.tbl_filter #(= (. $1 :sub) opts.args)
                                                      lsp-maps)
                             first (. filtered 1)]
                         (first.callback)))
        cmd-complete #(vim.tbl_map #(. $1 :sub) lsp-maps)
        add-sub #(buf-add-command bufnr :Lsp cmd-callback
                                  {:nargs 1
                                   :desc "Lsp command."
                                   :complete cmd-complete})
        set-keymap-single (fn [lhs callback desc]
                            (buf-set-keymap bufnr :n lhs ""
                                            {:silent true : callback : desc}))
        set-keymap-for-all (fn [lhs callback desc]
                             (vim.tbl_map #(set-keymap-single $1 callback desc)
                                          lhs))
        set-keymap (fn [lhs callback desc]
                     (match lhs
                       (where s (= (type s) :string)) (set-keymap-single s
                                                                         callback
                                                                         desc)
                       (where l (= (type l) :table)) (set-keymap-for-all l
                                                                         callback
                                                                         desc)
                       _ (error (string.format "%s is not table nor string, but %s"
                                               (vim.inspect lhs) (type lhs)))))]
    (add-sub)

    ;; Use custom nerd-font icons when using neovide GUI client.
    (when vim.g.neovide
      (setup-icons))

    (each [key value (pairs options)]
      (**> buf-set-option bufnr key value))

    (each [_ opts (ipairs lsp-maps)]
      (set-keymap opts.keymap opts.callback opts.description))))

;; Setup built-in LSP for each lsp server from above list.
(each [_ server (ipairs servers)]
  (let [config (. lsp-config server)
        capabilities (vim.lsp.protocol.make_client_capabilities)]
    (config.setup {:on_attach lsp-on-attach
                   :capabilities capabilities})))
