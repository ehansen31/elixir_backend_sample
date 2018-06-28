defmodule ElixirBackendSampleWeb.Resolvers.User do
  def create_user(_parent, args, _resolution) do
    alias ElixirBackendSampleWeb.Models.User
    alias ElixirBackendSample.Repo

    args = Map.put(args, :password_hash, Comeonin.Bcrypt.hashpwsalt(args.password))
    args = Map.delete(args, :password)

    changeset = User.changeset(%User{}, args)

    case Repo.insert(changeset) do
      {:error, changeset} -> {:error, changeset}
      {:ok, userObj} -> {:ok, userObj}
    end

    # %User{}
    # |> User.changeset(args)
    # |> Repo.insert()
  end

  def login(_parent, args, _resolution) do
    alias ElixirBackendSampleWeb.Models.User

    User.login(args)
  end

  def is_logged(_parent, _args, %{context: %{current_user: _current_user}}) do
    {:ok, true}
  end

  def is_logged(_parent, _args, _resolution) do
    {:error, false}
  end

  def update(_args, _info) do
    {:error, "Not Authorized"}
  end
end