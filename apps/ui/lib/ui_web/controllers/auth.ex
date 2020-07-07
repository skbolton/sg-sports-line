defmodule UIWeb.Auth do
  import Plug.Conn

  alias Accounts.User

  def init(opts), do: opts

  def call(conn, _opts) do
    user_id = get_session(conn, :user_id)
    user = user_id && Accounts.get_user(user_id)
    assign(conn, :current_user, user)
  end

  def login(conn, user) do
    conn
    |> assign(:current_user, user)
    |> put_session(:user_id, user.id)
    |> configure_session(renew: true)
  end

  @doc """
  Verifies that the current user is loaded and is an admin
  """
  def ensure_admin(%{assigns: %{current_user: %User{admin: true}}} = conn, _opts) do
    conn
  end

  def ensure_admin(not_admin_conn) do
    not_admin_conn
    |> put_status(401)
    |> halt()
  end
end
