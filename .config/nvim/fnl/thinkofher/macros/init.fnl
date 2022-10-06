(fn *> [f ...]
  (let [new-f-name (string.gsub (. f 1) "-" "_")]
    (list (sym new-f-name) ...)))

(fn **> [f ...]
  (let [new-f-name (string.gsub (. f 1) "-" "_")
        nvim-api-name (.. :vim.api.nvim_ new-f-name)]
    (list (sym nvim-api-name) ...)))

(fn use^ [package config]
  "use^ macro allows to fetch package with custom config table."
  (let [merged-table (do
                       (local out {})
                       (table.insert out package)
                       (each [key value (pairs config)]
                         (tset out key value))
                       out)]
    `(use ,merged-table)))

(fn once [body]
  "Evaluate given code only once during runtime."
  `(let [once-var# ,(tostring {})
         ;; generates random table address at compile time
         run?# (. _G once-var#)]
     (when (not run?#)
       ,body
       (tset _G once-var# true))))

(fn when-file-not-exist [filename ...]
  "Evaluate given body when given filename does not exist."
  (let [body (if ... `[(do
                         ,...)] `[])]
    `(when (> (vim.fn.empty (vim.fn.glob ,filename)) 0)
       ,(unpack body))))

(fn when-no-editorconfig [...]
  (when-file-not-exist :.editorconfig ...))

(fn last [table]
  "Returns last element from table."
  `(. ,table (length ,table)))

(fn lazy-hotpot [...]
  `(let [setup?# (= (. _G :lazy_hotpot) nil)]
     (when setup?#
       (let [hotpot# (require :hotpot)]
         (hotpot#.setup {:provide_require_fennel true
                         :compiler {:macros {:env :_COMPILER
                                             :compilerEnv _G
                                             :allowedGlobals false}}}))
       (tset _G :lazy_hotpot :ready))))

(fn kmp^ [cmd label opts]
  "kmp^ returns keymap table for which-key plugin config."
  (let [res (vim.tbl_extend :force [cmd label] (or opts {}))]
    res))

{: *>
 : **>
 : use^
 : kmp^
 : once
 : last
 : lazy-hotpot
 : kmp^
 : when-file-not-exist
 : when-no-editorconfig}
