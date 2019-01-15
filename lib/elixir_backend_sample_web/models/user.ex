defmodule ElixirBackendSampleWeb.Models.User do
  # use Ecto.Schema
  alias ElixirBackendSampleWeb.EctoSchema.User

  # import Ecto.Changeset
  import Ecto.Query

  alias ElixirBackendSample.Repo
  alias ElixirBackendSampleWeb.Email

  # schema "users" do
  #   field(:email, :string)
  #   field(:password_hash, :string)
  #   field(:first_name, :string)
  #   field(:last_name, :string)
  #   field(:age, :integer)
  #   field(:client_store, :map)
  #   has_many(:content, ElixirBackendSampleWeb.Models.Content)
  #   timestamps
  # end

    

  # def changeset(user, params \\ %{}) do
  #   user
  #   |> cast(params, [:email, :password_hash])
  #   |> validate_required([:email, :password_hash])
  #   |> validate_format(:email, ~r/@/)
  #   # |> validate_length(:password, min: 5, max: 10)
  #   # |> validate_inclusion(:age, 18..100)
  #   |> unique_constraint(:email)

  #   # |> put_password_hash()

  #   # |> unsafe_validate_unique(:email, Repo)
  # end

  def get_user(id) do
    # Create a query
    query =
      from(
        u in ElixirBackendSampleWeb.EctoSchema.User,
        where: u.id == ^id
      )

    Repo.one(query)
  end

  defp authenticate_user(email, given_password) do
    query = Ecto.Query.from(u in ElixirBackendSampleWeb.EctoSchema.User, where: u.email == ^email)

    Repo.one(query)
    |> check_password(given_password)
  end

  defp check_password(nil, _), do: {:error, "Email is not registered"}

  defp check_password(user, given_password) do
    case Comeonin.Bcrypt.checkpw(given_password, user.password_hash) do
      true -> {:ok, user}
      false -> {:error, "Incorrect password"}
    end
  end

  def login(args) do
    case authenticate_user(args.email, args.password) do
      {:ok, user} ->
        case ElixirBackendSample.Auth.Guardian.encode_and_sign(user) do
          {:ok, token, _claims} -> {:ok, token}
        end

      {:error, _reason} ->
        {:error, "Invalid Password"}
    end
  end

  def reset_password(args) do

    query = Ecto.Query.from(u in ElixirBackendSampleWeb.EctoSchema.User, where: u.email == ^args.email)

    user = Repo.one(query)

    new_password = :crypto.strong_rand_bytes(12) |> Base.url_encode64 |> binary_part(0, 12)

    hashed_password = Comeonin.Bcrypt.hashpwsalt(new_password)

    user_changeset = Ecto.Changeset.change(user, password_hash: hashed_password)
    case Repo.update user_changeset do
      {:error, changeset} -> {:error, changeset}
      {:ok, changeset} -> user_changeset = changeset
    end

    Email.password_reset_email(user, new_password) |> ElixirBackendSample.Mailer.deliver_later

    {:ok, "success"}
  end

  def update_user(user, args) do
    updated_user = Ecto.Changeset.change(user, args)

    case Repo.update updated_user do
      {:error, changeset} -> {:error, changeset}
      {:ok, changeset} -> {:ok, changeset}
    end
  end
end
