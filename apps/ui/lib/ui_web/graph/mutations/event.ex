defmodule UIWeb.Graph.Schema.Mutations.Event do
  use Absinthe.Schema.Notation
  alias UIWeb.Graph.Schema.Resolvers.Event

  object :event_mutations do
    field :create_event, non_null(:event) do
      arg :name, non_null(:string)
      arg :event_start, non_null(:datetime)
      arg :event_end, non_null(:datetime)
      arg :sheet_open, non_null(:datetime)
      arg :sheet_closed, non_null(:datetime)
      resolve &Event.create_event/2
    end
  end
end
