defmodule UIWeb.Graph.Schema.Queries.Athlete do
  use Absinthe.Schema.Notation
  alias UIWeb.Graph.Schema.Resolvers.Athlete

  object :athlete_queries do
    field :athlete_by_name, list_of(:athlete) do
      arg :fuzzy, :boolean
      arg :search, non_null(:string)
      resolve &Athlete.by_name/2
    end

    field :all_athletes, list_of(:athlete) do
      resolve &Athlete.all/2
    end
  end
end
