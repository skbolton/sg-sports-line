defmodule Events.EventAthlete do
  use Ecto.Schema
  alias Events.Event
  alias Athletes.Athlete

  schema "events_athletes" do
    field :cost, :integer
    field :winnings, :integer
    belongs_to :event, Event
    belongs_to :athlete, Athlete
    timestamps()
  end
end
