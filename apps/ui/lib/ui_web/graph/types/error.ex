defmodule UIWeb.Graph.Schema.Types.Error do
  use Absinthe.Schema.Notation

  object :invalid_params do
    @desc "The fields that have errors"
    field :fields, non_null(list_of(:string))
    @desc "The errors for the fields"
    field :errors, non_null(list_of(:string))
  end

  object :invalid_permissions do
    @desc "Explanation for invalid params"
    field :message, non_null(:string)
    @desc "Action being performed when permission error occured"
    field :action, non_null(:string)
  end
end
