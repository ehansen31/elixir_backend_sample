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
end
