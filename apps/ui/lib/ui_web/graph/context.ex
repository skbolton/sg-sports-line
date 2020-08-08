defmodule UIWeb.Graph.Context do
  @moduledoc """
  Module for preparing GraphQL context for resolvers.

  This module is where reading of values from `conn` to be put into context
  occurs.
  """
  @behaviour Plug
  @context_keys [:current_user]

  @impl Plug
  def init(opts), do: opts

  @impl Plug
  def call(conn, _opts) do
    context =
      conn.assigns
      |> Enum.filter(fn {key, _} -> key in @context_keys end)
      |> Map.new()

    Absinthe.Plug.put_options(conn, context: context)
  end
end

