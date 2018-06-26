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
    |> validate_inclusion(:age, 18..100)
    |> unique_constraint(:email)
    # |> unsafe_validate_unique(:email, Repo)
  end
end
