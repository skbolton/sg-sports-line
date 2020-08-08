defmodule UIWeb.Graph.Schema.Mutations.User do
  use Absinthe.Schema.Notation
  alias UIWeb.Graph.Schema.Resolvers.User

  object :user_mutations do
    field :request_auth_token, non_null(:auth_token) do
      arg :email, non_null(:string)
      arg :password, non_null(:string)
      resolve &User.request_auth_token/2
    end
  end
end
