defmodule UIWeb.Graph.Schema.Mutations.Event do
  use Absinthe.Schema.Notation

  alias Accounts.Authentication.InvalidPermission
  alias Events.Event
  alias UIWeb.Graph.Schema.Utils.InvalidParams
  alias UIWeb.Graph.Schema.Resolvers.Event, as: EventResolver

  union :create_event_result do
    types [:event, :invalid_params, :invalid_permissions]

    resolve_type fn
      %Event{}, _ -> :event
      %InvalidPermission{}, _ -> :invalid_permissions
      %InvalidParams{}, _ -> :invalid_params
    end
  end

  object :event_mutations do
    field :create_event, non_null(:create_event_result) do
      arg :name, non_null(:string)
      arg :event_start, non_null(:datetime)
      arg :event_end, non_null(:datetime)
      arg :sheet_open, non_null(:datetime)
      arg :sheet_closed, non_null(:datetime)
      resolve &EventResolver.create_event/2
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
      resolve &EventResolver.update/2
    end

    field :add_athlete_to_event, non_null(:event) do
      arg :event_id, non_null(:id)
      arg :athlete_id, non_null(:id)
      arg :cost, non_null(:integer)
      resolve &EventResolver.add_athlete/2
    end

    field :update_event_athlete, non_null(:event_athlete) do
      @desc "The id for the event athlete"
      arg :id, non_null(:id)
      arg :cost, non_null(:integer)
      arg :winnings, non_null(:integer)
      resolve &EventResolver.update_event_athlete/2
    end

    field :remove_event_athlete, non_null(:event) do
      @desc "Id for the event athlete to remove"
      arg :id, non_null(:id)

      resolve &EventResolver.remove_event_athlete/2
    end
  end
end
