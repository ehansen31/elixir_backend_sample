defmodule ElixirBackendSampleWeb.EctoSchema.User do
    use Ecto.Schema
    import Ecto.Changeset

    schema "users" do
      field(:email, :string)
      field(:password_hash, :string)
      field(:first_name, :string)
      field(:last_name, :string)
      field(:age, :integer)
      field(:client_store, :map)
      has_many(:content, ElixirBackendSampleWeb.EctoSchema.Content)
      timestamps
    end

    def changeset(user, params \\ %{}) do
        user
        |> cast(params, [:email, :password_hash])
        |> validate_required([:email, :password_hash])
        |> validate_format(:email, ~r/@/)
        # |> validate_length(:password, min: 5, max: 10)
        # |> validate_inclusion(:age, 18..100)
        |> unique_constraint(:email)

        # |> put_password_hash()

        # |> unsafe_validate_unique(:email, Repo)
    end
end

defmodule ElixirBackendSampleWeb.EctoSchema.Content do
    use Ecto.Schema
    import Ecto.Changeset

    schema "content" do
        belongs_to(:user, ElixirBackendSampleWeb.EctoSchema.User)
        field(:text, :string)
        timestamps
    end

    def changeset(content, params \\ %{}) do
        content
        |> cast(params, [:text])
        # |> validate_required([:user, :text])
    end
end