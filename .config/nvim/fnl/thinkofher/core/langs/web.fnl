;; settings for web development languages
(import-macros {: set!} :hibiscus.vim)
(import-macros {: **> : when-no-editorconfig} :thinkofher.macros)

(when-no-editorconfig (**> create-augroup :Web {})
                      (let [web-tabs (fn [...]
                                       (set! expandtab)
                                       (set! tabstop 2)
                                       (set! softtabstop 2)
                                       (set! shiftwidth 2))]
                        (**> create-autocmd :BufEnter
                             {:group :Web
                              :desc "Setup size of tabs for web dev files."
                              :pattern [:*.js :*.html :*.htm :*.css :*.tpl]
                              :nested false
                              :once false
                              :callback web-tabs}))
                      (**> create-autocmd [:BufNewFile :BufRead]
                           {:group :Web
                            :desc "Setup proper filetype for template fiels."
                            :pattern :*.tpl
                            :nested false
                            :once false
                            :callback (fn [...]
                                        (set! :filetype :html))}))
