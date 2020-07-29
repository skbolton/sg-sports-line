defmodule UIWeb.EventController do
  use UIWeb, :controller
  alias Events

  import UIWeb.Auth

  require Logger

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

      {:error, reason} ->
        Logger.error(inspect(reason))

        conn
        |> put_status(400)
        |> json(%{error: "There was an error"})
    end
  end
end
