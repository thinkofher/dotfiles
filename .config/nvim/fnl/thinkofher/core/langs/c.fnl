;; C, Cpp settings
(import-macros {: set!} :hibiscus.vim)
(import-macros {: **> : when-no-editorconfig} :thinkofher.macros)

;; C, Cpp auto command group
(**> create-augroup :CFamily {})

(local c-cpp-patterns [:*.c :*.cpp :*.h :*.hpp])

;; run clang-format before every buffer write
(**> create-autocmd :BufWritePre
     {:group :CFamily
      :desc "Autoformat c/cpp files on save."
      :pattern c-cpp-patterns
      :nested false
      :once false
      :callback #(vim.lsp.buf.format)})

(when-no-editorconfig (let [c-tabs (fn [...]
                                     (set! tabstop 2)
                                     (set! softtabstop 2)
                                     (set! shiftwidth 2))]
                        (**> create-autocmd :BufEnter
                             {:group :CFamily
                              :desc "Setup size of tabs for c/cpp files."
                              :pattern c-cpp-patterns
                              :nested false
                              :once false
                              :callback c-tabs})))
