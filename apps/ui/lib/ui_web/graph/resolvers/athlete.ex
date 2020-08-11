defmodule UIWeb.Graph.Schema.Resolvers.Athlete do
  alias Athletes

  def by_name(%{fuzzy: fuzzy, search: search}, _context) do
    {:ok, Athletes.get_by_name(search, fuzzy: fuzzy)}
  end
end
