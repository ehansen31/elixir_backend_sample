defmodule ElixirBackendSampleWeb.PageController do
  use ElixirBackendSampleWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
