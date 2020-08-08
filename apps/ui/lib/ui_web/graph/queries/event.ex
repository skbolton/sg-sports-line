defmodule UIWeb.Graph.Schema.Queries.Event do
  use Absinthe.Schema.Notation
  alias UIWeb.Graph.Schema.Resolvers.Event

  object :event_queries do
    field :active_events, list_of(:event) do
      resolve &Event.active/2
    end

    field :all_events, list_of(:event) do
      resolve &Event.all/2
    end
  end
end
