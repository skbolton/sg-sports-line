defmodule Events.Event do
  @moduledoc """
  Events are sporting events that users can purchase sheets against.

  Athletes of an event are given a cost to purchase based on Vegas odds. Events allow users
  to purchase sheets that grant them virtual currency to purchase athletes and try to assemble
  a group of athletes that will win the largest amount of money from the event. The top sheets
  with the largeset amount of athlete winnings will win the pool.

  ## Fields

  * `name` - name of the event
  * `event_start` - when the event starts
  * `event_end` - when the event ends
  * `sheet_cost` - how much a sheet costs
  * `funds_granted` - funds granted for purchasing athletes on sheet
  * `sheet_open` - when sheets can be purchased for event
  * `sheet_close` - cutuff for when sheets can no longer be purchased
  """
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:_id, :binary_id, autogenerate: false}

  embedded_schema do
    field(:name, :string)
    field(:sheet_cost, :integer, default: 20)
    field(:funds_granted, :integer, default: 100)
    field(:event_start, :utc_datetime)
    field(:event_end, :utc_datetime)
    field(:sheet_open, :utc_datetime)
    field(:sheet_close, :utc_datetime)
  end

  @doc """
  Creates a new event
  """
  def new_event(event, params \\ %{}) do
    event
    |> cast(params, [
      :name,
      :event_start,
      :event_end,
      :sheet_open,
      :sheet_close,
      :sheet_cost,
      :funds_granted
    ])
    |> validate_required([:name, :event_start, :event_end, :sheet_open, :sheet_close])
  end
end
