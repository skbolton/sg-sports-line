defmodule DB.Repo.Migrations.UniqueEventAthletes do
  use Ecto.Migration

  def change do
    create unique_index(:events_athletes, [:event_id, :athlete_id])
  end
end
