(import-macros {:opt-set set!
                : def-autocmd-fn} :zest.macros)

(def-autocmd-fn :FileType :go
  (set! :expandtab false)
  (set! :tabstop 4)
  (set! :softtabstop 4)
  (set! :shiftwidth 4))

(def-autocmd-fn [:BufNewFile :BufRead] :*.mod
  (set! :expandtab false)
  (set! :tabstop 4)
  (set! :softtabstop 4)
  (set! :shiftwidth 4))

;; vim-go settings
(tset vim.g :go_fmt_command "goimports")
(tset vim.g :go_fmt_autosave 1)

(tset vim.g :go_fmt_fail_silently 1)
(tset vim.g :go_asmfmt_autosave 1)
(tset vim.g :go_autodetect_gopath 1)
(tset vim.g :go_list_type  "quickfix")

(tset vim.g :go_highlight_types 1)
(tset vim.g :go_highlight_fields 1)
(tset vim.g :go_highlight_functions 1)
(tset vim.g :go_highlight_function_calls 1)
(tset vim.g :go_highlight_extra_types 1)
(tset vim.g :go_highlight_generate_tags 1)
(tset vim.g :go_highlight_operators 1)
(tset vim.g :go_echo_go_info 0)
(tset vim.g :go_auto_type_info 1)
(tset vim.g :go_metalinter_autosave_enabled
      ["vet" "golint" "errcheck"])
