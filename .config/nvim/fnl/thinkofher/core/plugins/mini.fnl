(import-macros {: **> : *> : last} :thinkofher.macros)

;; create sessions directory if needed
(let [data-path (vim.fn.stdpath :data)
      sessions-path (.. data-path :/session)]
  (when (= 0 (vim.fn.isdirectory sessions-path))
    (vim.fn.mkdir sessions-path)))

(fn just-call [sf ...]
  (sf))

(fn call-with-config [sf config]
  (sf config))

(fn statusline-active []
  (let [(mode mode-hl) (MiniStatusline.section_mode {:trunc_width 120})
        git (MiniStatusline.section_git {:trunc_width 75})
        diagnostics (MiniStatusline.section_diagnostics {:trunc_width 75})
        filename (MiniStatusline.section_filename {:trunc_width 140})
        fileinfo (MiniStatusline.section_fileinfo {:trunc_width 120})
        location (MiniStatusline.section_location {:trunc_width 75})
        groups [{:hl mode-hl :strings [mode]}
                {:hl :MiniStatuslineDevinfo :strings [git diagnostics]}
                "%<"
                ;; Mark general truncate point
                {:hl :MiniStatuslineFilename :strings [filename]}
                "%="
                ;; End left alignment
                {:hl :MiniStatuslineFileinfo :strings [fileinfo]}
                {:hl mode-hl :strings [location]}]]
    (MiniStatusline.combine_groups groups)))

(local statusline-config {:content {:active statusline-active}
                          :set_vim_settings false})

;; fnlfmt: skip
(let [mini-plugins [[:misc       just-call {}]
                    [:sessions   just-call {}]
                    [:tabline    call-with-config {:show_icons false
                                                   :set_vim_settings true}]
                    [:cursorword just-call {}]
                    [:comment    just-call {}]
                    [:bufremove  just-call {}]
                    [:statusline call-with-config statusline-config]]]
  (each [_ [sub-pkg config-func config-args] (ipairs mini-plugins)]
    (let [pkg-name (.. :mini. sub-pkg)
          pkg (require pkg-name)]
      (config-func pkg.setup config-args))))

;; Setup MBRDelete and MBRWipeout commands for invoking
;; MiniBufremove.delete and MiniBufremove.wipeout lua functions.
(let [bfr (require :mini.bufremove)
      commands {:Delete (. bfr :delete) :Wipeout (. bfr :wipeout)}
      to-bufnr (fn [buf-name]
                 (vim.fn.bufnr buf-name))
      all-buffers (fn [func bang]
                    (fn [buf-name]
                      (func (to-bufnr buf-name) bang)))
      callback (fn [func]
                 (fn [opts]
                   (match opts
                     ;; rest is empty so there is single command's argument
                     (where {:fargs [first & rest] : bang} (= (length rest) 0))
                     (func (to-bufnr first) bang)
                     ;; command execution with multiple arguments
                     (where {: fargs : bang} (> (length fargs) 0))
                     ;; apply function to all buffer names
                     (*> vim.tbl-map (all-buffers func bang) fargs)
                     ;; apply function to current buffer
                     {: bang}
                     (func nil bang))))]
  (each [cmd func (pairs commands)]
    ;; register command
    (**> create-user-command (.. :MBR cmd) (callback func)
         {:bang true :nargs "*" :complete #(vim.fn.getcompletion "*" :buffer)})))

;; Setup user commands for sessions manipulation.

(fn list-sessions [...]
  "Returns list with all saved sessions."
  (let [sessions (require :mini.sessions)]
    (*> vim.tbl-keys sessions.detected)))

(fn list-other-sessions [...]
  "Returns list of all sessions except the current one."
  (let [all-sessions (list-sessions)
        this-session (**> get-vvar :this_session)
        session-name (last (vim.split this-session "/" {:trimempty true}))]
    (*> vim.tbl-filter #(not (= session-name $1)) all-sessions)))

(fn read-session [opts]
  "Callback for 'MiniSessionsRead' custom user command."
  (let [sessions (require :mini.sessions)]
    (sessions.read (. opts :args))))

(fn write-session [opts]
  "Callback for 'MiniSessionsWrite' custom user command."
  (let [sessions (require :mini.sessions)]
    (match opts
      ;; there isn't any argument
      {:args "" :bang force}
      (sessions.write nil {: force})
      ;; write to session with given name
      {: args :bang force}
      (sessions.write args {: force}))))

(fn delete-session [opts]
  "Callback for 'MiniSessionsDelete' custom user command."
  (let [sessions (require :mini.sessions)]
    (match opts
      ;; there isn't any argument
      {:args "" :bang force}
      (sessions.delete nil {: force})
      ;; delete session with given name
      {: args :bang force}
      (sessions.delete args {: force}))))

(fn switch-session [opts]
  "Callback for 'MiniSessionsSwitch' custom user command. switch-session
  saves current session and loads sessionw with given name."
  (let [sessions (require :mini.sessions)
        session-name (. opts :args)]
    (sessions.write nil {:force true})
    (sessions.read session-name)))

(**> create-user-command :MiniSessionsRead read-session
     {:bang false :nargs 1 :complete list-sessions})

(**> create-user-command :MiniSessionsWrite write-session
     {:bang true :nargs "?" :complete list-sessions})

(**> create-user-command :MiniSessionsDelete delete-session
     {:bang true :nargs "?" :complete list-sessions})

(**> create-user-command :MiniSessionsSwitch switch-session
     {:bang false :nargs 1 :complete list-other-sessions})
