;; settings for data formats
(import-macros
  {:opt-set set!
   : def-autocmd-fn} :zest.macros)

;; proto
(def-autocmd-fn :FileType :proto
  (set! :tabstop 2)
  (set! :softtabstop 2)
  (set! :shiftwidth 2))

;; yaml
(def-autocmd-fn :FileType :yaml
  (set! :tabstop 2)
  (set! :softtabstop 2)
  (set! :shiftwidth 2))
