;; C, Cpp settings
(import-macros {: set!} :hibiscus.vim)
(import-macros {: **>
                : *>} :thinkofher.macros)

(fn c-tabs [...]
  (set! tabstop 2)
  (set! softtabstop 2)
  (set! shiftwidth 2))

;; C, Cpp file extension patterns
(local c-cpp-patterns [:*.c :*.cpp :*.h :*.hpp])

;; C, Cpp auto command group
(**> create-augroup :CFamily {})

;; run clang-format before every buffer write
(**> create-autocmd :BufWritePre {:group :CFamily
                                  :desc "Autoformat c/cpp files on save."
                                  :pattern c-cpp-patterns
                                  :nested false
                                  :once false
                                  :callback (fn [...] (*> vim.lsp.buf.formatting-sync))})

(**> create-autocmd :BufEnter {:group :CFamily
                               :desc "Setup size of tabs for c/cpp files."
                               :pattern c-cpp-patterns
                               :nested false
                               :once false
                               :callback c-tabs})
