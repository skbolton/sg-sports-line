defmodule Events do
  @moduledoc """
  Documentation for Events.
  """

  import Ecto.Query
  alias DB.Repo

  alias Events.{
    Event,
    EventAthlete
  }

  alias Athletes.Athlete

  def all do
    Repo.all(Event)
  end

  def active do
    now = DateTime.utc_now()
    Repo.all(from e in Event, where: e.sheet_open < ^now, where: e.sheet_closed > ^now)
  end

  def create_event(params) do
    Event.new_event_changeset(%Event{}, params)
    |> Repo.insert()
  end

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
