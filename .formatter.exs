# Used by "mix format"
[
  inputs: ["mix.exs", "config/*.exs"],
  import_deps: [:ecto, :absinthe],
  subdirectories: ["apps/*"]
]
