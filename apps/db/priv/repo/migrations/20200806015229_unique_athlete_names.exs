defmodule DB.Repo.Migrations.UniqueAthleteNames do
  use Ecto.Migration

  def change do
    create unique_index(:athletes, [:name])
  end
end
