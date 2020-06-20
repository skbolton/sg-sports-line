defmodule Athletes do
  alias Athletes.Athlete
  alias DB.Repo

  def create_athlete(params) do
    Athlete.new_athlete_changeset(%Athlete{}, params)
    |> Repo.insert()
  end
end
