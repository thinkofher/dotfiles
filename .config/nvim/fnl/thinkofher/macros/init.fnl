(fn *> [f ...]
  (let [new-f-name (string.gsub (. f 1) "-" "_")]
    (list (sym new-f-name) ...)))

(fn **> [f ...]
  (let [new-f-name (string.gsub (. f 1) "-" "_")
        nvim-api-name (.. "vim.api.nvim_" new-f-name)]
    (list (sym nvim-api-name) ...)))

{: *>
 : **>}
