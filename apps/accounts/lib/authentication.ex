defmodule Accounts.Authentication do
  use Guardian, otp_app: :accounts
  alias Accounts.User

  def subject_for_token(%User{id: id}, _claims) do
    {:ok, to_string(id)}
  end

  def resource_from_claims(%{"sub" => id}) do
    case Accounts.get_user(id) do
      nil ->
        {:error, :resource_not_found}

      %User{} = user ->
        {:ok, user}
    end
  end

  def build_claims(claims, %User{admin: admin}, _opts), do: {:ok, Map.put(claims, "admin", admin)}
end
