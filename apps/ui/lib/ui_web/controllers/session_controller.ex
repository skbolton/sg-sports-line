defmodule UIWeb.SessionController do
  use UIWeb, :controller

  def create(conn, %{"email" => email, "password" => password}) do
    case Accounts.auth_with_email(%{email: email, password: password}) do
      {:ok, user} ->
        conn
        |> UIWeb.Auth.login(user)
        |> put_status(200)
        |> json(%{})
    end
  end
end
