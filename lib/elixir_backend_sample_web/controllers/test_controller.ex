defmodule ElixirBackendSampleWeb.TestController do
  use ElixirBackendSampleWeb, :controller

  def create(conn, _params) do
    conn
    |> resp(201, "{}")
  end
end
