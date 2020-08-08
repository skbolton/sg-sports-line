defmodule UIWeb.SessionController do
  use UIWeb, :controller

  def create(conn, %{"email" => email, "password" => password}) do
    case Accounts.auth_with_email(%{email: email, password: password}) do
      {:ok, _token, user} ->
        conn
        |> UIWeb.Auth.login(user)
        |> json(%{admin: user.admin})
    end
  end
end
