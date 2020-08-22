defmodule DB.Repo.Migrations.DefaultEventAthleteWinnings do
  use Ecto.Migration
  import Ecto.Query
  alias DB.Repo
  alias Events.EventAthlete

  def up do
    alter table("events_athletes") do
      modify(:winnings, :integer, default: 0)
    end

    Repo.update_all(from(ea in EventAthlete, where: is_nil(ea.winnings)), set: [winnings: 0])
  end

  def down do
    :ok
  end
end
