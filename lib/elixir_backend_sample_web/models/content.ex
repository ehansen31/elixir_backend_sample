defmodule ElixirBackendSampleWeb.Models.Content do
    use Ecto.Schema

    import Ecto.Changeset
    import Ecto.Query

    alias ElixirBackendSample.Repo

    schema "content" do
        belongs_to(:user, ElixirBackendSampleWeb.Models.User)
        field(:text, :string)
        timestamps
    end
    def changeset(content, params \\ %{}) do
        content
        |> validate_required([:user, :text])
    end


    def create_content(user, text) do

        content = Ecto.build_assoc(user, :content, text: "Excellent!")
        changeset = Content.changeset(%Content{}, content)

        Repo.insert(changeset) do
            {:error, changeset} -> {:error, changeset}
            {:ok, contentObj} -> {:ok, contentObj}
        end
    end

    def get_content(id) do
        # Create a query
        query =
        from(
            c in ElixirBackendSampleWeb.Models.Content,
            where: c.id == ^id
        )

        # Send the query to the repository
        # potentially doesn't return just a user
        Repo.one(query)
    end

    def get_user_content do
        query = from(
            c in ElixirBackendSampleWeb.Models.Content,
            where: c.id == ^id
        )

        Repo.all(query)
    end
end