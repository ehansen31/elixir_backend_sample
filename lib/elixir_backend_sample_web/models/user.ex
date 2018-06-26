defmodule ElixirBackendSampleWeb.Models.User do
  use Ecto.Schema

  import Ecto.Changeset
  import Ecto.Query

  alias ElixirBackendSample.Repo

  schema "users" do
    field(:email, :string)
    field(:password, :string)
    field(:first_name, :string)
    field(:last_name, :string)
    field(:age, :integer)
  end

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, [:email, :password])
    |> validate_required([:email, :password])
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 5, max: 10)
    |> validate_inclusion(:age, 18..100)
    |> unique_constraint(:email)
    |> put_password_hash()

    # |> unsafe_validate_unique(:email, Repo)
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))

      _ ->
        changeset
    end
  end

  def get_user(id) do
    # Create a query
    query =
      from(
        u in "users",
        where: u.id == ^id
      )

    # Send the query to the repository
    # potentially doesn't return just a user
    Repo.one(query)
  end

  def login(args) do
    query =
      from(
        u in "users",
        where: u.email == ^args.email
      )

    case Repo.one(query) do
      {:ok, value} ->
        case ElixirBackendSample.Auth.authenticate_user(args.email, args.password) do
          {:ok, user} ->
            ElixirBackendSample.Auth.login(user)

          {:error, _reason} ->
            {:error, "Invalid Password"}
        end

      {:error, _reason} ->
        {:error, "Email is not registered"}
    end
  end
end
