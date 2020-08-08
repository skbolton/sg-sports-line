defmodule UIWeb.Graph.Schema.Types.User do
  use Absinthe.Schema.Notation

  object :user do
    @desc "The email of the user"
    field :email, non_null(:string)
    @desc "Whether the user is an admin"
    field :admin, non_null(:boolean)
  end

  object :auth_token do
    field :token, non_null(:string)
  end
end
