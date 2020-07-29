defmodule UIWeb.EventController do
  use UIWeb, :controller
  alias Events

  import UIWeb.Auth

  require Logger

  plug :ensure_admin when action in [:create, :all]

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

  def all(conn, _params) do
    events =
      Events.all()
      |> Enum.map(&Map.from_struct/1)
      |> Enum.map(&Map.delete(&1, :__meta__))
      |> Enum.map(&Map.delete(&1, :event_athletes))
      |> Enum.map(&Map.delete(&1, :athletes))

    conn
    |> json(%{events: events})
  end

  def active(conn, _params) do
    events =
      Events.active()
      |> Enum.map(&Map.from_struct/1)
      |> Enum.map(&Map.delete(&1, :__meta__))
      |> Enum.map(&Map.delete(&1, :event_athletes))
      |> Enum.map(&Map.delete(&1, :athletes))

    conn
    |> json(%{events: events})
  end
end
