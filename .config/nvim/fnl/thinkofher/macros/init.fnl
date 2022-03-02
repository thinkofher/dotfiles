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


{: *>
 : **>
 : use-with-config}
