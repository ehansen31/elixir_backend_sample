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
    alias ElixirBackendSample.Repo

    User.login(args)
  end

  def create_post(_parent, args, %{context: %{current_user: user}}) do
    Blog.Content.create_post(user, args)
  end

  def create_post(_parent, _args, _resolution) do
    {:error, "Access denied"}
  end
end
