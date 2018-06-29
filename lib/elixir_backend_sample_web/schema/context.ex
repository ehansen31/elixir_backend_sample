defmodule ElixirBackendSampleWeb.Context do
  @behaviour Plug

  import Plug.Conn
  import Ecto.Query

  alias ElixirBackendSample.Repo
  alias ElixirBackendSampleWeb.Models.User

  def init(opts), do: opts

  def call(conn, _) do
    case build_context(conn) do
      {:ok, context} ->
        put_private(conn, :absinthe, %{context: context})

      _ ->
        conn
    end
  end

  defp build_context(conn) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, current_user} <- authorize(token) do
      {:ok, %{current_user: current_user, token: token}}
    end
  end

  defp authorize(token) do
    case ElixirBackendSample.Auth.Guardian.resource_from_token(token) do
      {:ok, resource, _claims} -> {:ok, resource}
      {:error, _any} -> {:error, "Invalid authorization token"}
    end

    # User
    # |> where(token: ^token)
    # |> Repo.one()
    # |> case do
    #   nil -> {:error, "Invalid authorization token"}
    #   user -> {:ok, user}
    # end
  end
end
