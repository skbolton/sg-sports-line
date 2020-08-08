defmodule UIWeb.Graph.Schema.Resolvers.User do
  alias Accounts

  def request_auth_token(%{email: email, password: password}, _) do
    case Accounts.auth_with_email(%{email: email, password: password}) do
      {:ok, token, _user} ->
        {:ok, %{token: token}}
    end
  end
end
