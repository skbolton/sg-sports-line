defmodule UIWeb.Graph.Schema.Queries do
  use Absinthe.Schema.Notation

  alias __MODULE__

  import_types Queries.Event
  import_types Queries.Athlete

  object :queries do
    import_fields :event_queries
    import_fields :athlete_queries
  end
end
