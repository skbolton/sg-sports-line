defmodule UIWeb.EventController do
  use UIWeb, :controller
  alias Events

  import UIWeb.Auth

  plug :ensure_admin when action in [:create]

  def create(conn, %{"event" => event}) do
    case Events.create_event(event) do
      {:ok, event} ->
        event =
          event
          |> Map.from_struct()
          |> Map.delete(:__meta__)
          |> Map.delete(:event_athletes)
          |> Map.delete(:athletes)

        conn
        |> put_status(:created)
        |> json(%{event: event})
    end
  end
end
