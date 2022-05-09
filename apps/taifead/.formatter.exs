[
  import_deps: [:ecto],
  inputs: ["*.{ex,exs}", "priv/*/seeds.exs", "{config,lib,test}/**/*.{ex,exs}"],
  line_length: 144,
  subdirectories: ["priv/*/migrations"]
]
