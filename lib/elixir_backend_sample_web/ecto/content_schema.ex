defmodule ElixirBackendSampleWeb.Ecto.Content_Schema do
  use Ecto.Schema
  import Ecto.Changeset

  schema "content" do
      belongs_to(:user, ElixirBackendSampleWeb.Ecto.User_Schema)
      field(:text, :string)
      timestamps
  end

  def changeset(content, params \\ %{}) do
      content
      |> cast(params, [:text])
      # |> validate_required([:user, :text])
  end
end
