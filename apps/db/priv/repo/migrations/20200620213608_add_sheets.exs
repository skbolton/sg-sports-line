defmodule DB.Repo.Migrations.AddSheets do
  use Ecto.Migration

  def change do
    create table(:sheets) do
      add(:venmo_username, :string, null: false)
      add(:email, :string, null: false)
      add(:verified, :boolean, default: false, null: false)
      timestamps()
    end
  end
end
