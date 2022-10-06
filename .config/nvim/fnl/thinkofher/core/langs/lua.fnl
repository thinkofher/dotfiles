(import-macros {: set!} :hibiscus.vim)
(import-macros {: **> : when-no-editorconfig} :thinkofher.macros)

(when-no-editorconfig (let [lua-tabs (fn [...]
                                       (set! tabstop 4)
                                       (set! softtabstop 4)
                                       (set! shiftwidth 4))]
                        (**> create-augroup :Data {})
                        (**> create-autocmd :BufEnter
                             {:group :Data
                              :desc "Setup size of tabs for data files."
                              :pattern :*.lua
                              :nested false
                              :once false
                              :callback lua-tabs})))
