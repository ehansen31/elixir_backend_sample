defmodule ElixirBackendSampleWeb.Models.User do
  use Ecto.Schema

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

  def create_user(userObj) do
    # check if the email exists in the database?

    person = %ElixirBackendSampleWeb.Models.User{}
    ElixirBackendSample.Repo.insert(person)
  end
end
