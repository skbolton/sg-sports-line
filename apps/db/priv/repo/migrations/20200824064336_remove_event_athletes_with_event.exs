defmodule DB.Repo.Migrations.RemoveEventAthletesWithEvent do
  use Ecto.Migration

  def change do
    alter table(:events_athletes) do
      modify(:event_id, references(:events, on_delete: :delete_all), from: references(:events))
    end
  end
end
