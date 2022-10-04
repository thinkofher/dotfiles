;; Setup netrw plugin

(tset vim.g :netrw_banner 0)

;; disable annoying banner
(tset vim.g :netrw_altv 1)

;; open splits to the right
(tset vim.g :netrw_liststyle 3)

;; tree view
(tset vim.g :netrw_list_hide ",\\(^\\|\\s\\s\\)\\zs\\.\\S\\+")
