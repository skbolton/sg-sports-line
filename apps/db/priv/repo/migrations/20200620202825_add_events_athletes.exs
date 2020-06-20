defmodule DB.Repo.Migrations.AddEventsAthletes do
  use Ecto.Migration

  def change do
    create table(:events_athletes) do
      add(:cost, :integer, null: false)
      add(:winnings, :integer)
      add(:event_id, references(:events))
      add(:athlete_id, references(:athletes))
      timestamps()
    end
  end
end
