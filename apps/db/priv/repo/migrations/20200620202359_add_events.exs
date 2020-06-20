defmodule DB.Repo.Migrations.AddEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add(:name, :string, null: false)
      add(:event_start, :utc_datetime, null: false)
      add(:event_end, :utc_datetime, null: false)
      add(:sheet_cost, :integer, default: 20, null: false)
      add(:funds_granted, :integer, default: 100, null: false)
      add(:sheet_open, :utc_datetime, null: false)
      add(:sheet_closed, :utc_datetime, null: false)
      timestamps()
    end
  end
end
