defmodule Athletes do
  import Ecto.Query
  alias Accounts.Authentication.Claims
  alias Athletes.Athlete
  alias DB.Repo

  def all(%{auth: %Claims{admin: true}}) do
    {:ok, Repo.all(Athlete)}
  end

  def all(_non_admin), do: {:error, :not_authorized}

  def create_athlete(%{auth: %Claims{admin: true}} = params) do
    Athlete.new_athlete_changeset(%Athlete{}, params)
    |> Repo.insert()
  end

  def create_athlete(_not_admin), do: {:error, :not_authorized}

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
