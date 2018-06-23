defmodule ElixirBackendSampleWeb.Router do
  use ElixirBackendSampleWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ElixirBackendSampleWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    pipe_through :api
    get "/test", TestController, :create
  end

  # Other scopes may use custom stacks.
  # scope "/api", ElixirBackendSampleWeb do
  #   pipe_through :api
  # end
end
