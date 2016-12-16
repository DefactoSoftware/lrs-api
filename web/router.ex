defmodule LrsApi.Router do
  use LrsApi.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :bearer do
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
  end

  scope "/", LrsApi do
    pipe_through :browser

    get "/", PageController, :index
    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end


  # Other scopes may use custom stacks.
  scope "/api", LrsApi do
    pipe_through :api

    post "/auth", AuthController, :login
  end

  scope "/api", LrsApi do
    pipe_through [:api, :bearer]

    resources "/users", UserController
    resources "/statements",  StatementController
  end
end
