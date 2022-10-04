(import-macros {: g!} :hibiscus.vim)
(import-macros {: **>} :thinkofher.macros)

(local <k> vim.keymap.set)

;; setup map leader
(g! mapleader " ")

;; autocompletion with omnifunc
(<k> :i :<c-j> :<c-x><c-o>)

;; mappings for moving lines
(let [move-lines-maps [[:n :∆ ":m .+1<cr>=="]
                       [:n :Ż ":m .-2<cr>=="]
                       [:v :∆ ":m '>+1<cr>gv=gv"]
                       [:v :Ż ":m '<-2<cr>gv=gv"]]]
  (each [_ [mode lhs rhs] (pairs move-lines-maps)]
    (<k> mode lhs rhs)))

;; toggle grammar spelling
(<k> :n
      :<leader>cs
      #(tset vim.opt :spell (not (vim.opt.spell:get)))
      {:silent true
       :desc "Toggle spell"})

;; terminal settings
(<k> :t :<c-v><esc> "<c-\\><c-n>")
(<k> :n :<leader>t ":tabnew<cr>:terminal<cr>")

;; clipboard copy and paste
(<k> [:n :v] :<leader>by "\"*y" {:desc "Clipboard yank"})
(<k> [:n :v] :<leader>bY "\"*Y" {:desc "Clipboard yank"})
(<k> [:n :v] :<leader>bp "\"*p" {:desc "Clipboard paste"})
(<k> [:n :v] :<leader>bP "\"*P" {:desc "Clipboard paste"})

(fn lazy-packer-exec [func-name]
  "lazy-packer-exec returns function which calls function with
  given name."
  #(let [packer (require :packer)
         func (. packer func-name)]
     (func)))

;; plugins management
(<k> :n :<leader>ps (lazy-packer-exec :sync) {:desc "Update plugins"})
(<k> :n :<leader>pc (lazy-packer-exec :compile) {:desc "Compile plugins"})

(**> create-augroup :Terminal {})

(**> create-autocmd :TermOpen {:group :Terminal
                               :desc "Setup no spelling for terminal buffers."
                               :pattern :*
                               :nested false
                               :once false
                               :callback #(tset vim.wo :spell false)})

(**> create-autocmd [:TermOpen :BufEnter] {:group :Terminal
                                           :desc "Start text insert when entering term."
                                           :pattern "term://*"
                                           :nested false
                                           :once false
                                           :callback #(vim.cmd :startinsert)})
