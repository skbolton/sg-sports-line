defmodule UIWeb.Graph.Schema do
  use Absinthe.Schema

  import_types UIWeb.Graph.Schema.Types
  import_types UIWeb.Graph.Schema.Queries
  import_types UIWeb.Graph.Schema.Mutations

  query do
    import_fields :queries
  end

  mutation do
    import_fields :mutations
  end

  subscription do
  end
end
