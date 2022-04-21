(import-macros {: **>
                : *>} :thinkofher.macros)

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

;; Setup MBRDelete and MBRWipeout commands for invoking
;; MiniBufremove.delete and MiniBufremove.wipeout lua functions.
(let [bfr (require :mini.bufremove)
      commands {:Delete (. bfr :delete)
                :Wipeout (. bfr :wipeout)}
      all-buffers (fn [func bang]
                    (fn [bufnr]
                      (func (tonumber bufnr) bang)))
      callback (fn [func]
                 (fn [opts]
                   (match opts
                     (where {:fargs [first & rest] :bang bang} (= (length rest) 0))
                     (func (tonumber first) bang)
                     (where {:fargs fargs :bang bang} (> (length fargs) 0))
                     (*> vim.tbl-map (all-buffers func bang) fargs)
                     {:bang bang} (func nil bang))))]
  (each [cmd func (pairs commands)]
    (**> create-user-command (.. :MBR cmd) (callback func) {:bang true
                                                            :nargs :*})))
