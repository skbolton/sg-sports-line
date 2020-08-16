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

    field :update_event, non_null(:event) do
      arg :id, non_null(:id)
      arg :name, :string
      arg :event_start, :datetime
      arg :event_end, :datetime
      arg :sheet_open, :datetime
      arg :sheet_closed, :datetime
      arg :sheet_cost, :integer
      arg :funds_granted, :integer
      resolve &Event.update/2
    end

    field :add_athlete_to_event, non_null(:event) do
      arg :event_id, non_null(:id)
      arg :athlete_id, non_null(:id)
      arg :cost, non_null(:integer)
      resolve &Event.add_athlete/2
    end
  end
end
