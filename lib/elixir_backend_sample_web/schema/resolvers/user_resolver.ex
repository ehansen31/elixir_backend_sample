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

  def reset_password(_parent, args, _resolution) do
    alias ElixirBackendSampleWeb.Models.User

    User.reset_password(args)
  end

  def update_user(_parent, args, %{context: %{current_user: current_user}}) do
    alias ElixirBackendSampleWeb.Models.User

    cond do
      args.password != nil ->
        args = Map.put(args, :password_hash, Comeonin.Bcrypt.hashpwsalt(args.password))
        args = Map.delete(args, :password)
    end

    # settings = %{email_signature: "Josh Steiner", send_emails: true}

    User.update_user(current_user, args)
  end

  def update_user(_parent, args, _resolution) do
    {:error, "invalid user token"}
  end

  def update(_args, _info) do
    {:error, "Not Authorized"}
  end
end
