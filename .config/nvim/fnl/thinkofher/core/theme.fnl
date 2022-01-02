;; enable syntax highlighting
(vim.cmd "syntax enable")

(tset vim.g :tokyonight_style "night")
(tset vim.g :tokyonight_italic_functions true)
(tset vim.g :tokyonight_sidebars
      ["qf" "vista_kind" "terminal" "packer"])

;; Change the "hint" color to the "orange" color, and
;; make the "error" color bright red
(tset vim.g :tokyonight_colors {:hint "orange" :error "#ff0000"})

;; Load the colorscheme
(vim.cmd "colorscheme tokyonight")
