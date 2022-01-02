(import-macros
  {:opt-append set+
   :opt-set set!} :zest.macros)

;; legacy stuff
(vim.api.nvim_set_option "compatible" false)
(vim.cmd "filetype plugin on")
(vim.cmd "filetype plugin indent on")

;; finding files
(set+ :path "**")
(set! :wildmenu true)
