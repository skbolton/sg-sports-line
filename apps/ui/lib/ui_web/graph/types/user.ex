defmodule UIWeb.Graph.Schema.Types.User do
  use Absinthe.Schema.Notation

  object :user do
    @desc "The email of the user"
    field :email, non_null(:string)
    @desc "Whether the user is an admin"
    field :admin, non_null(:boolean)
  end
end
