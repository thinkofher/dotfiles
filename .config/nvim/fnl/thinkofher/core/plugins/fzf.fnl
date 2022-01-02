;; settings for web development languages
(import-macros {: def-keymap-fn} :zest.macros)

(tset vim.env :FZF_DEFAULT_COMMAND "ag --hidden -l -g \"\"")
(tset vim.g :fzf_layout {:down "25%"})

(def-keymap-fn :<c-p> [n :silent]
  (vim.cmd "silent Files"))
