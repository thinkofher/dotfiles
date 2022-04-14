(import-macros {: *>} :thinkofher.macros)

(local theme (require :mini.base16))

(fn just-call [sf ...]
  (sf))

(fn call-with-config [sf config]
  (sf config))

(let [mini-plugins [[:misc just-call {}]
                    [:completion just-call {}]
                    [:starter just-call {}]
                    [:sessions just-call {}]
                    [:pairs just-call {}]
                    [:tabline call-with-config {:show_icons false
                                                :set_vim_settings true}]
                    [:cursorword just-call {}]
                    [:comment just-call {}]
                    [:bufremove just-call {}]]]
  (each [_ [sub-pkg config-func config-args] (ipairs mini-plugins)]
    (let [pkg-name (.. :mini. sub-pkg)
          pkg (require pkg-name)]
      (config-func pkg.setup config-args))))
