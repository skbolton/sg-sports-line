defmodule DB.Repo.Migrations.AssocSheetsToEvent do
  use Ecto.Migration

  def change do
    alter table(:sheets) do
      add(:event_id, references(:events))
    end
  end
end
