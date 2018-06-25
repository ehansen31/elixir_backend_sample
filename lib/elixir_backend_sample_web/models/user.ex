defmodule ElixirBackendSampleWeb.Models.User do
  use Ecto.Schema
  # This is the one that includes cast
  import Ecto.Changeset
  import Ecto.Query

  # # weather is the DB table
  # schema "weather" do
  #   field :city,    :string
  #   field :temp_lo, :integer
  #   field :temp_hi, :integer
  #   field :prcp,    :float, default: 0.0
  # end
  schema "user" do
    field(:email, :string)
    field(:password, :string)
    field(:first_name, :string)
    field(:last_name, :string)
    field(:age, :integer)
  end

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, [:name, :email, :age])
    |> validate_required([:email, :password])
    |> validate_format(:email, ~r/@/)
    |> validate_inclusion(:age, 18..100)
    |> unique_constraint(:email)
  end

  def create_user(userObj) do
    # check if the email exists in the database?

    person = %ElixirBackendSampleWeb.Models.User{
      email: userObj.email,
      password: userObj.password,
      first_name: userObj.first_name,
      last_name: userObj.last_name,
      age: userObj.age
    }

    {:ok, newUserObj} = ElixirBackendSample.Repo.insert(person)

    # create a user token here?
  end
end
