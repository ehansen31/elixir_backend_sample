defmodule ElixirBackendSampleWeb.Models.Content do
    use Ecto.Schema

    import Ecto.Changeset
    import Ecto.Query

    alias ElixirBackendSample.Repo

    schema "content" do
        field(:type, :string)
        # field(:user_id, :user)
        field(:text, :string)
        field(:image, :string)
    end

    def changeset(content, params \\ %{}) do
        
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
end