defmodule DB.Repo.Migrations.UniqueEvents do
  use Ecto.Migration

  def change do
    create unique_index(:events, [:name, :event_start])
  end
end
