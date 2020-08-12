defmodule UIWeb.Graph.Schema.Mutations.Athlete do
  use Absinthe.Schema.Notation
  alias UIWeb.Graph.Schema.Resolvers.Athlete

  object :athlete_mutations do
    field :create_athlete, non_null(:athlete) do
      arg :name, non_null(:string)
      resolve &Athlete.create/2
    end
  end
end
