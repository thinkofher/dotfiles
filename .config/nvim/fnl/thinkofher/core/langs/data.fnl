;; settings for data formats
(import-macros {: set!} :hibiscus.vim)
(import-macros {: **>} :thinkofher.macros)

(macro space-tabs-size [size]
  `(fn [...]
     (set! expandtab)
     (set! tabstop 2)
     (set! softtabstop 2)
     (set! shiftwidth 2)))

;; Auto command group for data files.
(**> create-augroup :Data {})

(**> create-autocmd :FileType {:group :Data
                               :desc "Setup size of tabs for proto files."
                               :pattern [:proto]
                               :nested false
                               :once false
                               :callback (space-tabs-size 2)})

(**> create-autocmd :FileType {:group :Data
                               :desc "Setup size of tabs for yaml files."
                               :pattern [:yaml]
                               :nested false
                               :once false
                               :callback (space-tabs-size 2)})
