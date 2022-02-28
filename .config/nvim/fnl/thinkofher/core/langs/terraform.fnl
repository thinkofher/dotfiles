(import-macros
  {:opt-set set!
   : def-autocmd-fn} :zest.macros)

(def-autocmd-fn :FileType [:terraform]
  (set! :tabstop 2)
  (set! :softtabstop 2)
  (set! :shiftwidth 2))
