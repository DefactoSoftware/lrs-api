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

  pipeline :browser_auth do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.EnsureAuthenticated, handler: LrsApi.Token
    plug Guardian.Plug.LoadResource
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :api_auth do
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
  end

  scope "/", LrsApi do
    pipe_through :browser

    get "/", PageController, :index
    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end

  scope "/", LrsApi do
    pipe_through [:browser, :browser_auth]

    resources "/users", UserController, only: [:show, :index, :update]
  end

  # Other scopes may use custom stacks.
  scope "/api", LrsApi do
    pipe_through :api

    resources "/statements",  StatementController
    resources "/users", UserController
  end
end
