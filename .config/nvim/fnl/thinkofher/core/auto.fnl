(import-macros {: **>} :thinkofher.macros)

(**> create-augroup :Langs {})

(fn auto-lang [name pattern callback]
  "auto-lang setups auto-command with callback for given FileType pattern."
  (**> create-autocmd :FileType {:group :Langs
                                 :desc (.. "Setup programming environment for "
                                           name)
                                 : pattern
                                 :nested false
                                 :once true
                                 : callback}))

(fn auto-lang-with-config [config]
  "auto-lang-with-config setups auto-command with config object."
  (auto-lang config.name config.pattern config.callback))

(fn lang-settings [name]
  "lang-settings returns callback which loads language specific
  settings."
  #(require (.. :thinkofher.core.langs. name)))

;; fnlfmt: skip
(local configs [{:name     :Go
                 :pattern  :go
                 :callback (lang-settings :go)}
                {:name     "C/C++"
                 :pattern  [:c :cpp]
                 :callback (lang-settings :c)}
                {:name     :Web
                 :pattern  [:javascript :css :html]
                 :callback (lang-settings :web)}
                {:name     :Terraform
                 :pattern  [:tf :terraform]
                 :callback (lang-settings :terraform)}
                {:name     :Lisps
                 :pattern  [:lisp :scheme :fennel]
                 :callback (lang-settings :lisps)}
                {:name     :Data
                 :pattern  [:yaml :proto]
                 :callback (lang-settings :data)}])

(each [_ config (ipairs configs)]
  (auto-lang-with-config config))
