;; lisps-family languages settings
(import-macros {:opt-set set!
                : def-autocmd-fn} :zest.macros)

(def-autocmd-fn :FileType [:list :racket :scheme :fennel]
  (vim.cmd "RainbowParentheses")
  (set! :tabstop 2)
  (set! :softtabstop 2)
  (set! :shiftwidth 2))
