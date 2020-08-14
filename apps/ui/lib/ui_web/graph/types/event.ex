defmodule UIWeb.Graph.Schema.Types.Event do
  use Absinthe.Schema.Notation
  import_types Absinthe.Type.Custom

  object :event do
    field :id, non_null(:id)
    field :name, non_null(:string)
    @desc "When the actual event starts"
    field :event_start, non_null(:datetime)
    @desc "When the actual event ends"
    field :event_end, non_null(:datetime)
    @desc "When sheets can be purchased for event"
    field :sheet_open, non_null(:datetime)
    @desc "When sheets can no longer be purchased for the event"
    field :sheet_closed, non_null(:datetime)
    @desc "How much a sheet costs"
    field :sheet_cost, non_null(:integer)
    @desc "How much funds are give for each sheet"
    field :funds_granted, non_null(:integer)
  end
end
