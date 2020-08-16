defmodule Events.Event do
  use Ecto.Schema
  import Ecto.Changeset
  alias Athletes.Athlete
  alias Ecto.Changeset
  alias Events.EventAthlete

  @derive Jason.Encoder
  schema "events" do
    field :name, :string
    field :event_start, :utc_datetime
    field :event_end, :utc_datetime
    field :sheet_cost, :integer, default: 20
    field :funds_granted, :integer, default: 100
    field :sheet_open, :utc_datetime
    field :sheet_closed, :utc_datetime
    has_many :event_athletes, EventAthlete
    many_to_many :athletes, Athlete, join_through: EventAthlete
    timestamps()
  end

  def new_event_changeset(event, params \\ %{}) do
    event
    |> cast(params, [
      :name,
      :event_start,
      :event_end,
      :sheet_cost,
      :funds_granted,
      :sheet_open,
      :sheet_closed
    ])
    |> validate_required([
      :name,
      :event_start,
      :event_end,
      :sheet_open,
      :sheet_closed
    ])
    |> check_date_is_before(:event_start, :event_end)
    |> check_date_is_before(:sheet_open, :sheet_closed)
  end

  @spec check_date_is_before(%Ecto.Changeset{}, atom(), atom()) :: %Ecto.Changeset{}
  defp check_date_is_before(%Changeset{} = changeset, earlier, later) do
    earlier_value = get_field(changeset, earlier)
    later_value = get_field(changeset, later)

    if earlier_value != nil and later_value != nil and
         DateTime.compare(earlier_value, later_value) == :lt do
      changeset
    else
      add_error(changeset, earlier, "#{earlier} should be before #{later}")
    end
  end
end
