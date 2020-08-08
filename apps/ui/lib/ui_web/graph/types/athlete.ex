defmodule UIWeb.Graph.Schema.Types.Athlete do
  use Absinthe.Schema.Notation

  object :athlete do
    @desc "The full name of the athlete"
    field :name, non_null(:string)
  end
end
