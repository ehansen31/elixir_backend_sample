defmodule ElixirBackendSampleWeb.TestController do
  use ElixirBackendSampleWeb, :controller

  def create(conn, _params) do
    users = []
    json conn, users
  end
end
