defmodule UIWeb.Graph.Schema.Utils.InvalidParams do
  @moduledoc """
  Module for handling when resolvers receive invalid changesets from business
  logic
  """

  @type t :: %__MODULE__{
          fields: [atom()],
          errors: [String.t()]
        }

  defstruct fields: [], errors: []

  alias Ecto.Changeset

  @spec new(%Changeset{}) :: t()
  @doc """
  Given an invalid changeset returns a struct graph schema can use to represent
  invalid params on a mutation.
  """
  def new(%Changeset{valid?: false, errors: errors}) do
    errors
    |> Enum.reduce(%__MODULE__{}, fn {field, error}, invalid_params ->
      %__MODULE__{
        invalid_params
        | fields: [field | invalid_params.fields],
          errors: [error | invalid_params.errors]
      }
    end)
  end
end
