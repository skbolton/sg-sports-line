defmodule Events.Event do
  use Ecto.Schema

  schema "events" do
    field :name, :string
    field :event_start, :utc_datetime
    field :event_end, :utc_datetime
    field :sheet_cost, :integer, default: 20
    field :funds_granted, :integer, default: 100
    field :sheet_open, :utc_datetime
    field :sheet_closed, :utc_datetime
    timestamps()
  end
end
