source $(brew --prefix)/opt/fzf/shell/key-bindings.fish

function fish_user_key_bindings
  fish_vi_key_bindings
  fzf_key_bindings
end
