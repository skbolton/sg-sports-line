defmodule UIWeb.Graph.Schema.Mutations do
  use Absinthe.Schema.Notation

  import_types UIWeb.Graph.Schema.Mutations.User
  import_types UIWeb.Graph.Schema.Mutations.Event

  object :mutations do
    import_fields :user_mutations
    import_fields :event_mutations
  end
end
