defmodule ElixirBackendSampleWeb.Resolvers.User do
  def create_user(_parent, args, _resolution) do
    {:ok, ElixirBackendSampleWeb.Models.User.create_user(args)}
  end

  def create_post(_parent, args, %{context: %{current_user: user}}) do
    Blog.Content.create_post(user, args)
  end
  def create_post(_parent, _args, _resolution) do
    {:error, "Access denied"}
  end
end

