(import-macros {: g!} :hibiscus.vim)

(let [find-files-mappings [:<C-p> :<leader>ff]]
  (each [_ mapping (ipairs find-files-mappings)]
    (vim.keymap.set :n mapping ":FzfFiles<CR>" {:desc "Find file"})))

(tset vim.env :FZF_DEFAULT_COMMAND
      "fd --type f --strip-cwd-prefix --hidden --follow --exclude .git")

(g! fzf_layout {:window {:width 1.0
                         :height 0.35
                         :relative false
                         :yoffset 1.0
                         :border :sharp}})

(g! fzf_preview_window ["hidden,right,50%,<70(up,40%)" :ctrl-/])

(vim.keymap.set :n :<leader>fg ":FzfRg<CR>" {:desc "Live grep"})
(vim.keymap.set :n :<leader>fb ":FzfBuffers<CR>" {:desc "Find buffer"})