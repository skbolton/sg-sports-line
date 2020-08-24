defmodule UIWeb.Graph.Schema.Resolvers.Event do
  alias Accounts.Authentication.InvalidPermission
  alias Events.Event
  alias UIWeb.Graph.Schema.Utils.InvalidParams

  def active(_args, _context) do
    {:ok, Events.active()}
  end

  def all(_args, %{context: context}) do
    Events.all(%{auth: context[:current_user]})
  end

  def event_athletes(%Event{id: id}, _args, _resolution) do
    {:ok, Events.athletes_for_event(id)}
  end

  def available_athletes(%Event{id: id}, _args, _resolution) do
    {:ok, Events.available_athletes(id)}
  end

  def create_event(args, %{context: context}) do
    args
    |> Map.put(:auth, context[:current_user])
    |> Events.create_event()
    |> case do
      {:error, %Ecto.Changeset{} = changeset} ->
        {:ok, InvalidParams.new(changeset)}

      {:error, %InvalidPermission{}} = invalid_perm ->
        invalid_perm

      {:ok, _event} = success ->
        success
    end
  end

  def by_id(%{id: id}, _context) do
    case Events.by_id(id) do
      nil ->
        {:error, :not_found}

      event ->
        {:ok, event}
    end
  end

  def update(args, %{context: context}) do
    args
    |> Map.put(:auth, context[:current_user])
    |> Events.update_event()
  end

  def add_athlete(args, %{context: context}) do
    args
    |> Map.put(:auth, context[:current_user])
    |> Events.add_athlete_to_event()
  end

  def update_event_athlete(args, %{context: context}) do
    args
    |> Map.put(:auth, context[:current_user])
    |> Events.update_event_athlete()
  end
end
