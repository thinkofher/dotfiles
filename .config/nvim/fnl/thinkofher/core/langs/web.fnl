;; settings for web development languages
(import-macros
  {:opt-set set!
   : def-autocmd-fn} :zest.macros)

(def-autocmd-fn :FileType [:javascript :html :css]
  (set! :tabstop 2)
  (set! :softtabstop 2)
  (set! :shiftwidth 2))

;; set tpl file type to html
(def-autocmd-fn [:BufNewFile :BufRead] :*.tpl
  (set! :filetype "html"))
