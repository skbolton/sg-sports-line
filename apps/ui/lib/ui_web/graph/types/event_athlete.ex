defmodule UIWeb.Graph.Schema.Types.EventAthlete do
  alias UIWeb.Graph.Schema.Resolvers.Athlete
  use Absinthe.Schema.Notation

  object :event_athlete do
    @desc "id for event athlete"
    field :id, non_null(:id)
    @desc "How much the athlete costs in the event"
    field :cost, non_null(:decimal)
    @desc "How much the athlete won in the event"
    field :winnings, :decimal
    @desc "The athletes information"
    field :athlete, non_null(:athlete) do
      resolve &Athlete.by_id/3
    end
  end
end
