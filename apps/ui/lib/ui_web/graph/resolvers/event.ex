defmodule UIWeb.Graph.Schema.Resolvers.Event do
  def active(_args, _context) do
    {:ok, Events.active()}
  end

  def all(_args, %{context: context}) do
    Events.all(%{auth: context[:current_user]})
  end

  def create_event(args, %{context: context}) do
    args
    |> Map.put(:auth, context[:current_user])
    |> Events.create_event()
  end

  def by_id(%{id: id}, _context) do
    case Events.by_id(id) do
      nil ->
        {:error, :not_found}

      event ->
        {:ok, event}
    end
  end
end
