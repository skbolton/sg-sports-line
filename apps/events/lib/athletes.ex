defmodule Athletes do
  import Ecto.Query
  alias Athletes.Athlete
  alias DB.Repo

  def create_athlete(params) do
    Athlete.new_athlete_changeset(%Athlete{}, params)
    |> Repo.insert()
  end

  @doc """
  Searches athletes by name given `search` text.

  ## Options

  * [fuzzy: true] -> enable fuzzy searching.
  """
  def get_by_name(search, opts \\ []) do
    fuzzy = Keyword.get(opts, :fuzzy, false)

    search_string =
      if(fuzzy) do
        "%#{String.downcase(search)}%"
      else
        String.downcase(search)
      end

    # Need to be aware of like injection attacks here
    # What do you do to check the input
    Repo.all(from(a in Athlete, where: like(fragment("lower(?)", a.name), ^search_string)))
  end
end
