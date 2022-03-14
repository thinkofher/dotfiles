(import-macros
  {:opt-append set+
   :opt-set set!} :zest.macros)
(import-macros {: **>} :thinkofher.macros)

;; legacy stuff
(**> set-option "compatible" false)
(vim.cmd "filetype plugin on")
(vim.cmd "filetype plugin indent on")

;; finding files
(set+ :path "**")
(set! :wildmenu true)
