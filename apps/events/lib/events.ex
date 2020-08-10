defmodule Events do
  @moduledoc """
  Documentation for Events.
  """

  import Ecto.Query
  alias DB.Repo
  alias Accounts.Authentication.Claims

  alias Events.{
    Event,
    EventAthlete
  }

  alias Athletes.Athlete

  def all(%{auth: %Claims{admin: true}}) do
    {:ok, Repo.all(Event)}
  end

  def all(_not_admin), do: {:error, :not_admin}

  def active do
    now = DateTime.utc_now()
    Repo.all(from e in Event, where: e.sheet_open < ^now, where: e.sheet_closed > ^now)
  end

  def create_event(%{auth: %Claims{admin: true}} = params) do
    Event.new_event_changeset(%Event{}, params)
    |> Repo.insert()
  end

  def create_event(_not_admin), do: {:error, :not_admin}

  def add_athlete_to_event(%{event_id: event_id, athlete_id: athlete_id} = params) do
    athlete_task = Task.async(fn -> Repo.get(Athlete, athlete_id) end)
    event_task = Task.async(fn -> Repo.get(Event, event_id) end)

    with %Event{} <- Task.await(event_task),
         %Athlete{} <- Task.await(athlete_task) do
      EventAthlete.new_event_athlete_changeset(%EventAthlete{}, params)
      |> Repo.insert()
    end
  end
end
