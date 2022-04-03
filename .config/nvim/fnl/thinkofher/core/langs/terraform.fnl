(import-macros {: set!} :hibiscus.vim)
(import-macros {: **>} :thinkofher.macros)

(fn terraform-tabs [...]
  (set! tabstop 2)
  (set! softtabstop 2)
  (set! shiftwidth 2))

(local terraform-patterns [:*.tf])

;; Terraform auto command group.
(**> create-augroup :Terraform {})

(**> create-autocmd :BufEnter {:group :Terraform
                               :desc "Setup szie fo tabs for terraform files."
                               :pattern terraform-patterns
                               :nested false
                               :once false
                               :callback terraform-tabs})
