defmodule UIWeb.Auth do
  alias Plug.Conn

  alias Accounts.Authentication.Claims

  def init(opts), do: opts

  def call(conn, _opts) do
    claims = get_claims(conn)
    Conn.assign(conn, :current_user, claims)
  end

  def get_claims(conn) do
    with ["Bearer " <> token] <- Conn.get_req_header(conn, "authorization"),
         {:ok, claims} <- Accounts.Authentication.decode_and_verify(token) do
      %Claims{
        sub: claims["sub"],
        iat: claims["iat"],
        exp: claims["exp"],
        admin: claims["admin"]
      }
    else
      _ ->
        :unverfied
    end
  end
end
