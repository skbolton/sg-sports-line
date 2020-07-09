defmodule UIWeb.UserController do
  use UIWeb, :controller

  @doc """
  Creates a new user and session
  """
  def create(conn, %{"email" => email, "password" => password}) do
    case Accounts.register_user(%{email: email, password: password}) do
      {:ok, user} ->
        conn
        |> UIWeb.Auth.login(user)
        |> put_status(201)
        |> json(%{})
    end
  end
end
