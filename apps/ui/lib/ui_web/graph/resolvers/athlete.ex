defmodule UIWeb.Graph.Schema.Resolvers.Athlete do
  alias Athletes

  def all(_args, %{context: context}) do
    %{auth: context.current_user}
    |> Athletes.all()
  end

  def by_name(%{fuzzy: fuzzy, search: search}, _context) do
    {:ok, Athletes.get_by_name(search, fuzzy: fuzzy)}
  end

  def create(args, %{context: context}) do
    args
    |> Map.put(:auth, context[:current_user])
    |> Athletes.create_athlete()
  end
end
