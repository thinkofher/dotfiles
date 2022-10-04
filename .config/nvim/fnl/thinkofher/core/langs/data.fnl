;; settings for data formats
(import-macros {: set!} :hibiscus.vim)
(import-macros {: **>} :thinkofher.macros)

(macro space-tabs-size [size]
  `(fn [...]
     (set! expandtab)
     (set! tabstop 2)
     (set! softtabstop 2)
     (set! shiftwidth 2)))

;; Data files extension patterns.
(local data-patterns [:*.yml :*.yaml :*.proto])

;; Auto command group for data files.
(**> create-augroup :Data {})

(**> create-autocmd :BufEnter
     {:group :Data
      :desc "Setup size of tabs for data files."
      :pattern data-patterns
      :nested false
      :once false
      :callback (space-tabs-size 2)})
