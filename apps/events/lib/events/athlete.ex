defmodule Events.Athlete do
  @moduledoc """
  Athletes are athletes competing in `Events.Event`'s

  When players are purchasing sheets for an event they are purchasing currency to buy an
  athlete.

  ## Fields

  * `name` - the name of the athlete
  * `cost` - how much the athlete costs for purchase (this is based on Vegas odds of winning)
  * `winnings` - how much the athlete won from the event
  """
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:_id, :binary_id, autogenerate: false}

  embedded_schema do
    field(:name, :string)
    field(:cost, :integer)
    field(:winnings, :integer)
  end

  @doc """
  Creates a new athlete for an event
  """
  def new_athlete(athlete, params \\ %{}) do
    athlete
    |> cast(params, [:name, :cost])
    |> validate_required([:name, :cost])
  end
end
