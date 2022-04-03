(import-macros {: set!} :hibiscus.vim)
(import-macros {: **>} :thinkofher.macros)

(fn terraform-tabs [...]
  (set! tabstop 2)
  (set! softtabstop 2)
  (set! shiftwidth 2))

;; Terraform auto command group.
(**> create-augroup :Terraform {})

(**> create-autocmd :FileType {:group :Terraform
                               :desc "Setup szie fo tabs for terraform files."
                               :pattern :terraform
                               :nested false
                               :once false
                               :callback terraform-tabs})
