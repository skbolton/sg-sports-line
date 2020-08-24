defmodule DB.Repo.Migrations.ChangeEventAthleteIntegersToDecimals do
  use Ecto.Migration

  def change do
    alter table(:events_athletes) do
      modify(:winnings, :decimal, from: :integer)
      modify(:cost, :decimal, from: :integer)
    end
  end
end
