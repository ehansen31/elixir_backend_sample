defmodule ElixirBackendSampleWeb.GraphQlController do
  use ElixirBackendSampleWeb, :controller

  def data(conn, _params) do
    users = []
    json conn, users
  end



end
