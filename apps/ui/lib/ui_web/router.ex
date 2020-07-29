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

  scope "/", UIWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", UIWeb do
    pipe_through :api

    post "/users", UserController, :create
    resources "/sessions", SessionController, only: [:create]
    post "/events", EventController, :create
    get "/events/all", EventController, :all
    get "/events/active", EventController, :active
  end

  get("/*path", UIWeb.PageController, :index)

  # Other scopes may use custom stacks.
  # scope "/api", UIWeb do
  #   pipe_through :api
  # end
end
