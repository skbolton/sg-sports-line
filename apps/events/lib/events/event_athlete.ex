defmodule Events.EventAthlete do
  use Ecto.Schema
  import Ecto.Changeset
  alias Events.Event
  alias Athletes.Athlete

  schema "events_athletes" do
    field :cost, :decimal
    field :winnings, :decimal, default: 0
    belongs_to :event, Event
    belongs_to :athlete, Athlete
    timestamps()
  end

  def new_event_athlete_changeset(event_athlete, params \\ %{}) do
    event_athlete
    |> cast(params, [:cost, :event_id, :athlete_id])
    |> validate_required([:cost, :event_id, :athlete_id])
  end

  def update_changeset(event_athlete, params) do
    event_athlete
    |> cast(params, [:cost, :winnings])
    |> validate_required([:cost, :winnings])
  end
end
