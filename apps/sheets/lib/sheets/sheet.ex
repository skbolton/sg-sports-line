defmodule Sheets.Sheet do
  use Ecto.Schema
  alias Events.Event

  schema "sheets" do
    field :venmo_username, :string
    field :email, :string
    field :verified, :boolean, default: false
    belongs_to :event, Event
    many_to_many :athletes, EventAthlete, join_through: "sheets_athletes"
    timestamps()
  end
end
