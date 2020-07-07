defmodule Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :admin, :boolean

    timestamps()
  end

  def regiseter_user_changeset(user, params \\ %{}) do
    user
    |> cast(params, [:email, :password])
    |> validate_required([:email, :password])
    |> put_password_hash()
  end

  def make_admin_changeset(user), do: change(user, admin: true)

  defp put_password_hash(%Ecto.Changeset{valid?: true} = changeset) do
    password = get_field(changeset, :password)
    put_change(changeset, :password_hash, Argon2.hash_pwd_salt(password))
  end

  defp put_password_hash(invalid_changeset), do: invalid_changeset
end
