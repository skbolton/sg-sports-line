defmodule Accounts.Authentication do
  use Guardian, otp_app: :accounts
  alias Accounts.User

  def subject_for_token(%User{id: id}, _claims) do
    {:ok, to_string(id)}
  end

  def resource_for_claims(%{"sub" => id}) do
    case Accounts.get_user(id) do
      nil ->
        {:error, :resource_not_found}
      %User{} = user ->
        {:ok, user}
    end
  end
end
