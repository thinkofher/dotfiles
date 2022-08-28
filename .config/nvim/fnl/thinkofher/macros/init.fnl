(fn *> [f ...]
  (let [new-f-name (string.gsub (. f 1) "-" "_")]
    (list (sym new-f-name) ...)))

(fn **> [f ...]
  (let [new-f-name (string.gsub (. f 1) "-" "_")
        nvim-api-name (.. "vim.api.nvim_" new-f-name)]
    (list (sym nvim-api-name) ...)))

;; use-with-config macro allows to fetch package
;; with custom config table.
(fn use-with-config [package config]
  (let [merged-table (do
                       (local out {})
                       (table.insert out package)
                       (each [key value (pairs config)]
                         (tset out key value))
                       out)]
    `(use ,merged-table)))

(fn once [body]
  "Evaluate given code only once during runtime."
  `(let [once-var# ,(tostring {}) ;; generates random table address at compile time
         run?# (. _G once-var#)]
     (when (not run?#)
       ,body
       (tset _G once-var# true))))

(fn last [table]
  "Returns last element from table."
  `(. ,table (length ,table)))

{: *>
 : **>
 : use-with-config
 : once
 : last}
