defmodule ElixirBackendSampleWeb.TestController do
  use ElixirBackendSampleWeb, :controller

  def return(conn, _params) do
    users = []
    json conn, users
  end
end
