defmodule UIWeb.Router do
  use UIWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  # This pipeline can be removed once api is fully moved to graph
  pipeline :graph do
    plug :accepts, ["json"]
    plug :fetch_session
    plug UIWeb.Auth
    plug UIWeb.Graph.Context
  end

  scope "/", UIWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/graph" do
    pipe_through :graph

    forward "/", Absinthe.Plug, schema: UIWeb.Graph.Schema
  end

  get("/*path", UIWeb.PageController, :index)

  # Other scopes may use custom stacks.
  # scope "/api", UIWeb do
  #   pipe_through :api
  # end
end
