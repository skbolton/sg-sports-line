defmodule UIWeb.Graph.Schema.Queries do
  use Absinthe.Schema.Notation

  import_types UIWeb.Graph.Schema.Queries.Event

  object :queries do
    import_fields :event_queries
  end
end
