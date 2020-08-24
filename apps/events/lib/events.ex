defmodule Events do
  @moduledoc """
  Documentation for Events.
  """

  import Ecto.Query
  alias DB.Repo
  alias Accounts.Authentication.{Claims, InvalidPermission}

  alias Events.{
    Event,
    EventAthlete
  }

  alias Athletes.Athlete

  @doc """
  Gets an event by `id`
  """
  def by_id(id) do
    Repo.get(Event, id)
  end

  def all(%{auth: %Claims{admin: true}}) do
    {:ok, Repo.all(Event)}
  end

  def all(_not_admin), do: {:error, InvalidPermission.new("view:all_events")}

  def athletes_for_event(event_id) do
    query = from(ea in EventAthlete, where: ea.event_id == ^event_id)

    Repo.all(query)
  end

  def available_athletes(event_id) do
    query =
      from(a in Athlete,
        left_join: ea in EventAthlete,
        on: a.id == ea.athlete_id,
        where: ea.event_id != ^event_id
      )

    Repo.all(query)
  end

  def active do
    now = DateTime.utc_now()
    Repo.all(from e in Event, where: e.sheet_open < ^now, where: e.sheet_closed > ^now)
  end

  def create_event(%{auth: %Claims{admin: true}} = params) do
    Event.new_event_changeset(%Event{}, params)
    |> Repo.insert()
  end

  def create_event(_not_admin), do: {:error, InvalidPermission.new("create:event")}

  def update_event(%{auth: %Claims{admin: true}} = params) do
    case Repo.get(Event, params.id) do
      %Event{} = event ->
        Event.new_event_changeset(event, params)
        |> Repo.update()

      nil ->
        {:error, :not_found}
    end
  end

  def add_athlete_to_event(
        %{auth: %Claims{admin: true}, event_id: event_id, athlete_id: athlete_id} = params
      ) do
    athlete_task = Task.async(fn -> Repo.get(Athlete, athlete_id) end)
    event_task = Task.async(fn -> Repo.get(Event, event_id) end)

    with %Event{} = event <- Task.await(event_task),
         %Athlete{} <- Task.await(athlete_task),
         {:ok, %EventAthlete{}} <-
           Repo.insert(EventAthlete.new_event_athlete_changeset(%EventAthlete{}, params)) do
      {:ok, event}
    end
  end

  def add_athlete_to_event(_non_admin) do
    {:error, InvalidPermission.new("create:event_athlete")}
  end

  def update_event_athlete(%{auth: %Claims{admin: true}, id: id} = params) do
    case Repo.get(EventAthlete, id) do
      %EventAthlete{} = ea ->
        EventAthlete.update_changeset(ea, params)
        |> Repo.update()

      nil ->
        {:error, :not_found}
    end
  end
end
