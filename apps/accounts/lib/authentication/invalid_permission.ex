defmodule Accounts.Authentication.InvalidPermission do
  @moduledoc """
  Error when current user does action that is admin only
  """

  @type t :: %__MODULE__{
          message: String.t(),
          action: String.t()
        }

  @enforce_keys [:message, :action]
  defstruct [:message, :action]

  @spec new(String.t()) :: t()
  @doc """
  Creates a new struct
  """
  def new(action) do
    %__MODULE__{
      message: "You must be an admin to perform #{action}",
      action: action
    }
  end
end
