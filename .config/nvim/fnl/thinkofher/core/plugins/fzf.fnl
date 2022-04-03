;; settings for web development languages

(tset vim.env :FZF_DEFAULT_COMMAND "ag --hidden -l -g \"\"")
(tset vim.g :fzf_layout {:down "25%"})

(vim.keymap.set :n :<c-p> #(vim.cmd "silent Files"))
