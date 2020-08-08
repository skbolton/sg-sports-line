defmodule UIWeb.Graph.Schema do
  use Absinthe.Schema

  import_types UIWeb.Graph.Schema.Types
  import_types UIWeb.Graph.Schema.Queries

  query do
    import_fields :queries
  end

  mutation do
  end

  subscription do
  end
end
