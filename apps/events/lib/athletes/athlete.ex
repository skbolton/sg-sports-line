defmodule Athletes.Athlete do
  use Ecto.Schema

  schema "athletes" do
    field :name, :string
    timestamps()
  end
end
