defmodule Accounts do
  @moduledoc """
  Documentation for `Accounts`.
  """
  alias Accounts.User
  alias DB.Repo

  @doc """
  Registers a new admin
  """
  def register_user(params) do
    User.regiseter_user_changeset(%User{}, params)
    |> Repo.insert()
  end

  @doc """
  Converts user to an admin
  """
  def make_admin(user_id) do
    with %User{} = user <- Repo.get(User, user_id),
         changeset <- User.make_admin_changeset(user) do
      Repo.update(changeset)
    else
      nil ->
        {:error, "User not found"}
    end
  end

  @doc """
  Get a user by id
  """
  def get_user(id) do
    Repo.get(User, id)
  end

  def auth_with_email(%{email: email, password: password}) do
    with %User{} = user <- Repo.get_by(User, %{email: email}),
         {:ok, %User{} = user} <- Argon2.check_pass(user, password),
         {:ok, token, _claims} <-
           Accounts.Authentication.encode_and_sign(user) do
      {:ok, token, user}
    else
      nil ->
        {:error, "User not found"}

      # TODO: need to figure out what to do here
      # Probably not a good idea to return what password check returns in error
      error ->
        error
    end
  end
end
