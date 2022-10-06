(import-macros {: set!} :hibiscus.vim)
(import-macros {: **> : when-no-editorconfig} :thinkofher.macros)

(when-no-editorconfig (let [terraform-tabs (fn [...]
                                             (set! tabstop 2)
                                             (set! softtabstop 2)
                                             (set! shiftwidth 2))
                            terraform-patterns [:*.tf]]
                        (**> create-augroup :Terraform {})
                        (**> create-autocmd :BufEnter
                             {:group :Terraform
                              :desc "Setup szie fo tabs for terraform files."
                              :pattern terraform-patterns
                              :nested false
                              :once false
                              :callback terraform-tabs})))
