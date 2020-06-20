defmodule DB.Repo.Migrations.AddAthletes do
  use Ecto.Migration

  def change do
    create table(:athletes) do
      add(:name, :string, null: false)
      timestamps()
    end
  end
end
