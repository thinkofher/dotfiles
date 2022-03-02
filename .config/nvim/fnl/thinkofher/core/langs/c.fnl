;; C, Cpp settings
(import-macros {:opt-set set!} :zest.macros)
(import-macros {: **>} :thinkofher.macros)

(fn c-tabs [...]
  (set! :tabstop 2)
  (set! :softtabstop 2)
  (set! :shiftwidth 2))

;; C, Cpp auto command group
(**> create-augroup :CFamily {})

;; run clang-format before every buffer write
(**> create-autocmd :BufWritePre {:group :CFamily
                                  :desc "Autoformat c/cpp files on save."
                                  :pattern [:*c :*cpp :*h :*hpp]
                                  :nested false
                                  :once false
                                  :callback (fn [...]
                                              (*> vim.lsp.buf.formatting-sync))})

(**> create-autocmd :FileType {:group :CFamily
                               :desc "Setup size of tabs for c/cpp files."
                               :pattern [:c :cpp]
                               :nested false
                               :once false
                               :callback c-tabs})
