defmodule UIWeb.Router do
  use UIWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
    plug UIWeb.Auth
  end

  # This pipeline can be removed once api is fully moved to graph
  pipeline :graph do
    plug :accepts, ["json"]
    plug UIWeb.Graph.Context
  end

  scope "/", UIWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", UIWeb do
    pipe_through :api

    post "/users", UserController, :create
    resources "/sessions", SessionController, only: [:create]
    post "/events", EventController, :create
    get "/events/", EventController, :all
    get "/events/:id", EventController, :show
    get "/events/active", EventController, :active
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
