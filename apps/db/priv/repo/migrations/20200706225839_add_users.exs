defmodule DB.Repo.Migrations.AddUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:email, :string, null: false)
      add(:password_hash, :string, null: false)
      add(:admin, :boolean, default: false, null: false)

      timestamps()
    end
  end
end
