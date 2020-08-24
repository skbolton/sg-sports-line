defmodule DB.Repo.Migrations.RemoveEventAthletesWithAthlete do
  use Ecto.Migration

  def change do
    alter table(:events_athletes) do
      modify(:athlete_id, references(:athletes, on_delete: :delete_all),
        from: references(:athletes)
      )
    end
  end
end
