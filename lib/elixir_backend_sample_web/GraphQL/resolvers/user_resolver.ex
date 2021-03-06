defmodule ElixirBackendSampleWeb.Resolvers.User_Resolver do
  alias ElixirBackendSampleWeb.Models.User

  def create_user(_parent, args, _resolution) do
    args = Map.put(args, :password_hash, Comeonin.Bcrypt.hashpwsalt(args.password))
    args = Map.delete(args, :password)

    User.create_user(args)
  end

  def login(_parent, args, _resolution) do
    User.login(args)
  end

  def is_logged(_parent, _args, %{context: %{current_user: _current_user}}) do
    {:ok, true}
  end

  def is_logged(_parent, _args, _resolution) do
    {:error, false}
  end

  def get_user(_parent, _args, %{context: %{current_user: current_user}}) do
    {:ok, current_user}
  end

  def get_user(_parent, _args, _resolution) do
    {:error, "invalid user token"}
  end

  def reset_password(_parent, args, _resolution) do
    User.reset_password(args)
  end

  def update_user(_parent, args, %{context: %{current_user: current_user}}) do
    cond do
      args[:password] != nil ->
        args = Map.put(args, :password_hash, Comeonin.Bcrypt.hashpwsalt(args.password))
        args = Map.delete(args, :password)

      true ->
        "Default value"
    end

    User.update_user(current_user, args)
  end

  def update_user(_parent, args, _resolution) do
    {:error, "invalid user token"}
  end

  def update(_args, _info) do
    {:error, "Not Authorized"}
  end
end
