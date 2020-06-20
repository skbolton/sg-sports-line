defmodule Athletes.Athlete do
  use Ecto.Schema
  import Ecto.Changeset

  schema "athletes" do
    field :name, :string
    timestamps()
  end

  def new_athlete_changeset(athlete, params \\ %{}) do
    athlete
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end
