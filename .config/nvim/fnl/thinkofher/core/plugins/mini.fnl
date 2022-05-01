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
      to-bufnr (fn [buf-name]
                 (vim.fn.bufnr buf-name))
      all-buffers (fn [func bang]
                    (fn [buf-name]
                      (func (to-bufnr buf-name) bang)))
      callback (fn [func]
                 (fn [opts]
                   (match opts
                     ;; rest is empty so there is single command's argument
                     (where {:fargs [first & rest] :bang bang} (= (length rest) 0))
                       (func (to-bufnr first) bang)
                     ;; command execution with multiple arguments
                     (where {:fargs fargs :bang bang} (> (length fargs) 0))
                       ;; apply function to all buffer names
                       (*> vim.tbl-map (all-buffers func bang) fargs)
                     ;; apply function to current buffer
                     {:bang bang} (func nil bang))))]
  (each [cmd func (pairs commands)]
    ;; register command
    (**> create-user-command (.. :MBR cmd) (callback func) {:bang true
                                                            :nargs :*
                                                            :complete #(vim.fn.getcompletion :* :buffer)})))
