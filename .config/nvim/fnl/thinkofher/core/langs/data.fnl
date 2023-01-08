;; settings for data formats
(import-macros {: set!} :hibiscus.vim)
(import-macros {: **> : when-no-editorconfig} :thinkofher.macros)

(when-no-editorconfig (let [data-tabs (fn [...]
                                        (set! tabstop 2)
                                        (set! softtabstop 2)
                                        (set! shiftwidth 2))
                            data-patterns [:*.yml :*.yaml :*.proto]]
                        (**> create-augroup :Data {})
                        (**> create-autocmd :BufEnter
                             {:group :Data
                              :desc "Setup size of tabs for data files."
                              :pattern data-patterns
                              :nested false
                              :once false
                              :callback data-tabs})))
