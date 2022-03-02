;; settings for web development languages
(import-macros {:opt-set set!} :zest.macros)
(import-macros {: **>} :thinkofher.macros)

(**> create-augroup :Web {})

(**> create-autocmd :FileType {:group :Web
                               :desc "Setup size of tabs for web dev files."
                               :pattern [:javascript :html :css]
                               :nested false
                               :once false
                               :callback (fn [...]
                                           (set! :tabstop 2)
                                           (set! :softtabstop 2)
                                           (set! :shiftwidth 2))})

(**> create-autocmd [:BufNewFile :BufRead] {:group :Web
                                            :desc "Setup proper filetype for template fiels."
                                            :pattern :*.tpl
                                            :nested false
                                            :once false
                                            :callback (fn [...]
                                                        (set! :filetype :html))})
