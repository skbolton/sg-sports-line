defmodule UIWeb.Graph.Schema.Resolvers.Event do
  def active(_args, _context) do
    {:ok, Events.active()}
  end
end
