defmodule Events do
  @moduledoc """
  Documentation for Events.
  """

  alias DB.Repo
  alias Events.Event

  def create_event(params) do
    Event.new_event_changeset(%Event{}, params)
    |> Repo.insert()
  end
end
