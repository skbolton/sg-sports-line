defmodule DB.Repo.Migrations.AddSheetsAthletes do
  use Ecto.Migration

  def change do
    create table(:sheets_athletes) do
      add(:sheet_id, references(:sheets))
      add(:event_athlete_id, references(:events_athletes))
    end

    create(unique_index(:sheets_athletes, [:sheet_id, :event_athlete_id]))
  end
end
