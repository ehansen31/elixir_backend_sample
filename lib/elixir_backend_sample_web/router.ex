defmodule ElixirBackendSampleWeb.Router do
  use ElixirBackendSampleWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", ElixirBackendSampleWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)
  end

  # Other scopes may use custom stacks.
  # scope "/api", ElixirBackendSampleWeb do
  #   pipe_through :api
  # end
  # Other scopes may use custom stacks.
  scope "/api" do
    pipe_through(:api)
    forward("/graphiql", Absinthe.Plug.GraphiQL, schema: ElixirBackendSampleWeb.Schema)

    forward("/", Absinthe.Plug, schema: ElixirBackendSampleWeb.Schema)
  end
end
