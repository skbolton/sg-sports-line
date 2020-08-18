defmodule UIWeb.Graph.Schema.Types do
  use Absinthe.Schema.Notation
  alias __MODULE__

  import_types Types.Event
  import_types Types.User
  import_types Types.Athlete
  import_types Types.Error
end
