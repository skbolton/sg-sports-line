defmodule UIWeb.Graph.Schema.Mutations do
  use Absinthe.Schema.Notation

  import_types UIWeb.Graph.Schema.Mutations.User

  object :mutations do
    import_fields :user_mutations
  end
end
