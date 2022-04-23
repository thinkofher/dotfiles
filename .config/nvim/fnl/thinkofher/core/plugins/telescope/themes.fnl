(local themes (require :telescope.themes))

(fn get-ivy [...]
  "get-ivy is wrapper around telescome.themes.get_ivy with
  custom configuration."
  (themes.get_ivy {:layout_config {:height 15}}))

{: get-ivy}
